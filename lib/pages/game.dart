import 'dart:async';
import 'package:card_game_sockets/models/playerModel.dart';
import 'package:card_game_sockets/models/roomModel.dart';
import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:card_game_sockets/widgets/backside.dart';
import 'package:card_game_sockets/widgets/looseDialog.dart';
import 'package:card_game_sockets/widgets/pauseScreen.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:card_game_sockets/widgets/winDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/cardModel.dart';
import '../widgets/forfeitDialog.dart';
import '../widgets/playerNameTag.dart';

class GamePage extends StatefulWidget {
  final String roomId;
  const GamePage({super.key, required this.roomId});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  StreamSubscription<DatabaseEvent>? roomSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomSubscription = FirebaseDatabase.instance
        .ref()
        .child('rooms')
        .child(widget.roomId)
        .onValue
        .listen((event) {
      Map<String, dynamic> room = event.snapshot.value as Map<String, dynamic>;
      RoomModel roomModel = RoomModel.fromJson(room);
      PlayerModel player1Model = PlayerModel.fromJson(roomModel.players[0]);
      PlayerModel player2Model = PlayerModel.fromJson(roomModel.players[1]);

      discardPile = roomModel.discardPile;
      player1 = player1Model;
      player2 = player2Model;
      turn = roomModel.turnIndex;
      winner = roomModel.isWon;
      playerWon = roomModel.playerWon;
      isPaused = roomModel.isPaused;
      playerPauseId = roomModel.playerPauseId;

      if (player1Model.knock && _auth.currentUser!.uid != player1.playerId) {
        Fluttertoast.showToast(
          timeInSecForIosWeb: 2,
            webBgColor: "FireBrick",
            webPosition: "left",
            msg: "${player1.username} has one card left",
            gravity: ToastGravity.TOP);
      }
      if (player2Model.knock && _auth.currentUser!.uid != player2.playerId) {
        Fluttertoast.showToast(
          timeInSecForIosWeb: 2,
            webBgColor: "FireBrick",
            webPosition: "left",
            msg: "${player2.username} has one card left",
            gravity: ToastGravity.TOP);
      }

      if (roomModel.isWon) {
        if (playerWon == _auth.currentUser?.uid) {
          showWinDialog(context);
        } else {
          showLooseDialog(context);
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    roomSubscription?.cancel();
    onGameExit(widget.roomId);

    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<CardModel> discardPile = [];
  int turn = 0;
  bool isPlayer1Turn = true;
  bool winner = false;
  String playerWon = '';
  bool isPaused = false;
  String playerPauseId = '';
  PlayerModel player1 = PlayerModel(
      playerId: '',
      roomId: '',
      username: '',
      knock: false,
      pauseCount: 2,
      isturn: false,
      hand: []);
  PlayerModel player2 = PlayerModel(
      playerId: '',
      roomId: '',
      username: '',
      knock: false,
      pauseCount: 2,
      isturn: false,
      hand: []);

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

    if (assignTurn(turn)) {
      setState(() {
        isPlayer1Turn = true;
      });
    } else {
      setState(() {
        isPlayer1Turn = false;
      });
    }

    final currentPlayer =
        currentUser!.uid == player1.playerId ? player1 : player2;
    final opponent = currentUser.uid == player1.playerId ? player2 : player1;

    int playerTurn = currentUser.uid == player1.playerId ? 0 : 1;
    return isPaused
        ? PauseMenu(roomId: widget.roomId, playerPauseId: playerPauseId)
        : Scaffold(
            backgroundColor: Colors.green.shade800,
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: Column(
              children: [
                const SizedBox(height: 20),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () => showForfeitDialog(context),
                  child: const Text("QUIT"),
                ),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                      currentPlayer.pauseCount,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: FloatingActionButton(
                                heroTag: index,
                                backgroundColor: Colors.red,
                                onPressed: () =>
                                    onGamePause(widget.roomId, playerTurn),
                                child: const Icon(Icons.pause)),
                          )).toList(),
                )
              ],
            ),
            body: Center(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.asset("assets/background.jpg",
                              fit: BoxFit.cover)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                          width: 120,
                          height: 80,
                          child: Image.asset('assets/nxtgen_tp.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PlayerNameTag(
                            name: opponent.username,
                            isTurn: currentUser.uid == player1.playerId
                                ? !isPlayer1Turn
                                : isPlayer1Turn),
                        SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: Center(
                            child: Stack(
                              children:
                                  List.generate(opponent.hand.length, (index) {
                                final fanOffsetX = index * 20.0;
                                return Transform.translate(
                                  offset: Offset(fanOffsetX, 0),
                                  child: const Backside(),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () => pickCard(
                                    widget.roomId, turn, playerTurn, context),
                                child: const Backside()),
                            const SizedBox(width: 100),
                            PlayingCard(
                                suit: discardPile.isEmpty
                                    ? ""
                                    : discardPile[discardPile.length - 1].suit,
                                value: discardPile.isEmpty
                                    ? ""
                                    : discardPile[discardPile.length - 1].rank)
                          ],
                        ),
                        SizedBox(
                          height: 160,
                          width: double.infinity,
                          child: Center(
                            child: Stack(
                              children: List.generate(currentPlayer.hand.length,
                                  (index) {
                                final playedCard = currentPlayer.hand[index];
                                final fanOffsetX = index * 30.0;
                                final deckSize = currentPlayer.hand.length * 33;
                                final double width =
                                    MediaQuery.of(context).size.width;
                                return Positioned(
                                  left: ((width / 2) - (deckSize / 2)) +
                                      fanOffsetX,
                                  child: GestureDetector(
                                    onTap: () {
                                      CardModel discardCard = discardPile
                                              .isEmpty
                                          ? CardModel(suit: '', rank: '')
                                          : discardPile[discardPile.length - 1];
                                      playCard(
                                        widget.roomId,
                                        playedCard,
                                        discardCard,
                                        playerTurn,
                                        turn,
                                        context,
                                      );
                                    },
                                    child: PlayingCard(
                                      suit: playedCard.suit,
                                      value: playedCard.rank,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        PlayerNameTag(
                            name: currentPlayer.username,
                            isTurn: currentUser.uid == player1.playerId
                                ? isPlayer1Turn
                                : !isPlayer1Turn),
                      ]),
                ],
              ),
            ));
  }
}
