import 'package:card_game_sockets/utils/deck.dart';
import 'package:card_game_sockets/utils/validator.dart';
import 'package:card_game_sockets/widgets/errorDialog.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/cardModel.dart';
import '../models/playerModel.dart';
import '../models/roomModel.dart';

List playerHands = [];

void initializeGame(String roomId) async {
  DatabaseReference roomRef =
      FirebaseDatabase.instance.ref().child('rooms').child(roomId);
  List<CardModel> deck = [];
  deck = buildDeck();
  deck.shuffle();
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
    }
    roomModel.discardPile.add(deck.removeLast());
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

void playCard(String roomId, CardModel playedCard, CardModel topCard,
    int playerIndex, int turnIndex, context) async {
  if (checkTurn(playerIndex, turnIndex)) {
    if (cardValidator(playedCard, topCard)) {
      DatabaseReference roomRef =
          FirebaseDatabase.instance.ref().child('rooms').child(roomId);
      final snapshot = await roomRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
        RoomModel roomModel = RoomModel.fromJson(data);
        roomModel.discardPile.add(playedCard);
        roomModel.players[playerIndex]['hand'].removeWhere((card) =>
            card['suit'] == playedCard.suit && card['rank'] == playedCard.rank);
        if(playedCard.rank != "8" && playedCard.rank != 'J'){
          roomModel.turnIndex++;
        }
        roomRef.set(roomModel.toJson());
      }
    } else {
      showErrorDialog(
          'Wrong Card!', 'Make sure the suit or rank match', context);
    }
  } else {
    showErrorDialog('Not Your Turn!', 'Wait for opponent move', context);
  }
}

void pickCard(String roomId) async {
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
    roomModel.turnIndex++;
    roomRef.set(roomModel.toJson());
  }
}
