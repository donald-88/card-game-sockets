import 'package:card_game_sockets/utils/deck.dart';
import 'package:card_game_sockets/utils/validator.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/cardModel.dart';
import '../models/playerModel.dart';
import '../models/roomModel.dart';
import '../widgets/aceDialog.dart';
import '../widgets/customDialog.dart';

List playerHands = [];

void initializeGame(String roomId) async {
  DatabaseReference roomRef =
      FirebaseDatabase.instance.ref().child('rooms').child(roomId);
  List<CardModel> deck = [];
  deck = buildDeck();
  deck.shuffle();

  //deal cards
  final snapshot = await roomRef.get();
  if (snapshot.exists) {
    Map<String, dynamic> roomData = snapshot.value as Map<String, dynamic>;
    RoomModel roomModel = RoomModel.fromJson(roomData);
    for (var player in roomModel.players) {
      PlayerModel playerModel = PlayerModel.fromJson(player);
      for (int i = 0; i < 4; i++) {
        playerModel.hand.add(deck.removeLast());
      }
      player.putIfAbsent(
          'hand', () => playerModel.hand.map((e) => e.toJson()).toList());

      

      player['pauseCount'] = 1;
    }

    for (int i = deck.length - 1; i >= 0; i--) {
      if (deck[i].rank != "J" &&
          deck[i].rank != "A" &&
          deck[i].rank != "2" &&
          deck[i].rank != "8" &&
          deck[i].rank != "JOKER") {
        roomModel.discardPile.add(deck.removeAt(i));
        break;
      }
    }

    roomModel.drawPile = deck;
    roomRef.set(roomModel.toJson());
  } else {
    print('No data available.');
  }
}

List dealCards(int numberOfPlayers, List deck) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < numberOfPlayers; j++) {
      playerHands[i].add(deck.removeLast());
    }
  }
  return playerHands;
}

bool assignTurn(int turnIndex) {
  int turn = turnIndex % 2;
  if (turn == 0) {
    return true;
  } else {
    return false;
  }
}

void playCard(String roomId, CardModel playedCard, CardModel topCard,
    int playerIndex, int turnIndex, context) async {
  if (checkTurn(playerIndex, turnIndex)) {
    if (cardValidator(playedCard, topCard)) {
      if (checkAce(playedCard)) {
        DatabaseReference roomRef =
            FirebaseDatabase.instance.ref().child('rooms').child(roomId);
        final snapshot = await roomRef.get();
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
          RoomModel roomModel = RoomModel.fromJson(data);

          //avoid finishing game with an Ace
          if (roomModel.players[playerIndex]['hand'].length == 1 &&
              playedCard.rank == "A") {
            CardModel toPickCard = roomModel.drawPile.removeLast();
            roomModel.players[playerIndex]['hand']
                .add({"suit": toPickCard.suit, "rank": toPickCard.rank});
            roomModel.turnIndex++;
          }

          roomModel.discardPile.add(playedCard);
          roomModel.players[playerIndex]['hand'].removeWhere((card) =>
              card['suit'] == playedCard.suit &&
              card['rank'] == playedCard.rank);
          if (roomModel.players[playerIndex]['hand'].length != 1) {
            roomModel.players[playerIndex]['knock'] = false;
          }

          if (roomModel.players[playerIndex]['hand'].length == 1) {
            roomModel.players[playerIndex]['knock'] = true;
          }
          roomRef.set(roomModel.toJson());
        }

        showAceDialog(context, roomId);
      } else {
        DatabaseReference roomRef =
            FirebaseDatabase.instance.ref().child('rooms').child(roomId);
        final snapshot = await roomRef.get();
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
          RoomModel roomModel = RoomModel.fromJson(data);

          //avoid finishing game with a wildcard
          if (roomModel.players[playerIndex]['hand'].length == 1 &&
              (playedCard.rank == "JOKER" ||
                  playedCard.rank == "2" ||
                  playedCard.rank == "8" ||
                  playedCard.rank == "J")) {
            CardModel toPickCard = roomModel.drawPile.removeLast();
            roomModel.players[playerIndex]['hand']
                .add({"suit": toPickCard.suit, "rank": toPickCard.rank});
            roomModel.turnIndex++;
          }

          roomModel.players[playerIndex]['hand'].removeWhere((card) =>
              card['suit'] == playedCard.suit &&
              card['rank'] == playedCard.rank);
          roomModel.discardPile.add(playedCard);

          //pick Joker
          if (playedCard.rank == "JOKER") {
            int turn = (turnIndex + 1) % 2;
            for (int i = 0; i < 4; i++) {
              CardModel toPickCard = roomModel.drawPile.removeLast();
              roomModel.players[turn]['hand']
                  .add({"suit": toPickCard.suit, "rank": toPickCard.rank});
            }
          }

          //pick 2
          if (playedCard.rank == "2") {
            int turn = (turnIndex + 1) % 2;
            for (int i = 0; i < 2; i++) {
              CardModel toPickCard = roomModel.drawPile.removeLast();
              roomModel.players[turn]['hand']
                  .add({"suit": toPickCard.suit, "rank": toPickCard.rank});
            }
          }

          //skip 8 and j
          if (playedCard.rank != "8" &&
              playedCard.rank != 'J' &&
              playedCard.rank != '2' &&
              playedCard.rank != "JOKER") {
            roomModel.turnIndex++;
          }

          if (roomModel.players[playerIndex]['hand'].length != 1) {
            roomModel.players[playerIndex]['knock'] = false;
          }

          if (roomModel.players[playerIndex]['hand'].length == 1) {
            roomModel.players[playerIndex]['knock'] = true;
          }

          //check for winner
          if (roomModel.players[playerIndex]['hand'].length == 0 &&
              playedCard.rank != "JOKER" &&
              playedCard.rank != "2" &&
              playedCard.rank != "8" &&
              playedCard.rank != "J" &&
              playedCard.rank != "A") {
            roomModel.isWon = true;
            roomModel.playerWon = roomModel.players[playerIndex]['playerId'];
          }
          roomRef.set(roomModel.toJson());
        }
      }
    } else {
      showCustomDialog(
          context, 'error', 'Wrong Card!', 'Make sure the suit or rank match');
    }
  } else {
    showCustomDialog(
        context, 'error', 'Not Your Turn!', 'Wait for opponent move');
  }
}

void pickCard(String roomId, int turn, int playerIndex, context) async {
  if (checkTurn(playerIndex, turn)) {
    DatabaseReference roomRef =
        FirebaseDatabase.instance.ref().child('rooms').child(roomId);
    final snapshot = await roomRef.get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
      RoomModel roomModel = RoomModel.fromJson(data);
      int turn = roomModel.turnIndex % 2;
      CardModel pickedCard = roomModel.drawPile.removeLast();
      roomModel.players[turn]['hand']
          .add({"suit": pickedCard.suit, "rank": pickedCard.rank});
      if (roomModel.players[turn]['hand'].length != 1) {
        roomModel.players[turn]['knock'] = false;
      }
      if (roomModel.drawPile.length == 1) {
        List<CardModel> tempDeck = [];
        for (int i = 0; i < roomModel.discardPile.length; i++) {
          tempDeck.add(roomModel.discardPile.removeAt(i));
          tempDeck.shuffle();
        }
        for (int j = 0; j <= tempDeck.length; j++) {
          roomModel.drawPile.add(tempDeck[j]);
        }
      }
      roomModel.turnIndex++;
      roomRef.set(roomModel.toJson());
    }
  } else {
    showCustomDialog(
        context, 'error', 'Not Your Turn!', 'Wait for opponent move');
  }
}

void playAce(String roomId, String suite) async {
  DatabaseReference roomRef =
      FirebaseDatabase.instance.ref().child('rooms').child(roomId);
  final snapshot = await roomRef.get();
  if (snapshot.exists) {
    Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
    RoomModel roomModel = RoomModel.fromJson(data);
    roomModel.discardPile.add(CardModel(suit: suite, rank: ''));
    roomModel.turnIndex++;
    roomRef.set(roomModel.toJson());
  }
}

void onGameExit(String roomId) async {
  DatabaseReference roomRef =
      FirebaseDatabase.instance.ref().child('rooms').child(roomId);
  final snapshot = await roomRef.get();
  if (snapshot.exists) {
    Map<String, dynamic> roomData = snapshot.value as Map<String, dynamic>;
    RoomModel roomModel = RoomModel.fromJson(roomData);
    roomModel.canJoin = true;
    roomRef.set(roomModel.toJson());
  }
}

void onGamePause(String roomId, int playerIndex) async {
  DatabaseReference roomRef =
      FirebaseDatabase.instance.ref().child('rooms').child(roomId);
  final snapshot = await roomRef.get();
  if (snapshot.exists) {
    Map<String, dynamic> roomData = snapshot.value as Map<String, dynamic>;
    RoomModel roomModel = RoomModel.fromJson(roomData);
    roomModel.isPaused = true;
    roomModel.players[playerIndex]['pauseCount']--;
    roomModel.playerPauseId = roomModel.players[playerIndex]['playerId'];
    roomRef.set(roomModel.toJson());
  }
}

void onGameResume(String roomId) async {
  DatabaseReference roomRef =
      FirebaseDatabase.instance.ref().child('rooms').child(roomId);
  final snapshot = await roomRef.get();
  if (snapshot.exists) {
    Map<String, dynamic> roomData = snapshot.value as Map<String, dynamic>;
    RoomModel roomModel = RoomModel.fromJson(roomData);
    roomModel.isPaused = false;
    roomRef.set(roomModel.toJson());
  }
}
