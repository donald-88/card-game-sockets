import 'package:card_game_sockets/models/playerModel.dart';
import 'package:card_game_sockets/models/roomModel.dart';
import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:card_game_sockets/widgets/backside.dart';
import 'package:card_game_sockets/widgets/forfeitDialog.dart';
import 'package:card_game_sockets/widgets/knockDialog.dart';
import 'package:card_game_sockets/widgets/pausedDialog.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:card_game_sockets/widgets/winDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/cardModel.dart';
import '../widgets/playerNameTag.dart';

class GamePage extends StatefulWidget {
  final String roomId;
  const GamePage({super.key, required this.roomId});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDatabase.instance
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

      if (player1Model.knock) {
        showKnockDialog(context, player1.username);
      }
      if (player2Model.knock) {
        showKnockDialog(context, player2.username);
      }

      if (roomModel.isWon) {
        showWinDialog(context, playerWon);
      }
      if (roomModel.isPaused) {
        showPausedDialog(context, widget.roomId);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

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
  PlayerModel player1 = PlayerModel(
      playerId: '',
      roomId: '',
      username: '',
      knock: false,
      pauseCount: 0,
      isturn: false,
      hand: []);
  PlayerModel player2 = PlayerModel(
      playerId: '',
      roomId: '',
      username: '',
      knock: false,
      pauseCount: 0,
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
    return Scaffold(
        backgroundColor: Colors.green.shade800,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
                heroTag: 1,
                backgroundColor: Colors.red,
                onPressed: () => showForfeitDialog(context),
                child: const Text('QUIT')),
            const SizedBox(height: 20),
            FloatingActionButton(
                heroTag: 2,
                backgroundColor: Colors.red,
                onPressed: () {
                  onGamePause(widget.roomId);
                },
                child: const Icon(Icons.pause))
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
                          children:
                              List.generate(currentPlayer.hand.length, (index) {
                            final playedCard = currentPlayer.hand[index];
                            final fanAngle =
                                (index - currentPlayer.hand.length / 2) * 0.3;
                            final fanOffsetX = index * 20.0;
                            return Transform.translate(
                              offset: Offset(fanOffsetX, 0),
                              child: Transform.rotate(
                                  angle: fanAngle,
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
                                  )),
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
