import 'dart:async';
import 'package:card_game_sockets/models/playerModel.dart';
import 'package:card_game_sockets/models/roomModel.dart';
import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:card_game_sockets/utils/sessionTimeOutListener.dart';
import 'package:card_game_sockets/widgets/backside.dart';
import 'package:card_game_sockets/widgets/customDialog.dart';
import 'package:card_game_sockets/widgets/knockDialog.dart';
import 'package:card_game_sockets/pages/menu/pauseScreen.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/cardModel.dart';
import '../widgets/playerAvatar.dart';
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
        showKnockDialog(context, player1.username);
      }
      if (player2Model.knock && _auth.currentUser!.uid != player2.playerId) {
        showKnockDialog(context, player2.username);
      }

      if (roomModel.isWon) {
        if (playerWon == _auth.currentUser?.uid) {
          showCustomDialog(
              context, 'success', 'W I N N E R ! !', 'You won the game!');
        } else {
          showCustomDialog(
              context, 'error', 'L O S E R ! !', 'You lost the game!');
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
      avatar: '',
      knock: false,
      pauseCount: 2,
      hand: []);
  PlayerModel player2 = PlayerModel(
      playerId: '',
      roomId: '',
      username: '',
      avatar: '',
      knock: false,
      pauseCount: 2,
      hand: []);

  bool showTimer = false;
  int timeLeft = 10;
  void _startCountDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

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
                  heroTag: 'quit',
                  backgroundColor: Colors.red,
                  onPressed: () => showCustomDialog(
                      context,
                      'forfeit',
                      'F O R F E I T ! !',
                      'Are you sure you want to forfeit the match?'),
                  child: Text("QUIT",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white)),
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
                                child: const Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )),
                          )).toList(),
                ),
                showTimer
                    ? FloatingActionButton(
                        heroTag: 'timer',
                        backgroundColor: Colors.red,
                        onPressed: () {},
                        child: Text(timeLeft.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white)))
                    : const SizedBox()
              ],
            ),
            body: SessionTimeoutListener(
              duration: const Duration(seconds: 30),
              onTimeOut: () {
                setState(() {
                  showTimer = true;
                });
                _startCountDown();
              },
              child: Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          width: width,
                          height: height,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //opponent hand
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              PlayerNameTag(
                                  name: opponent.username,
                                  isTurn: currentUser.uid == player1.playerId
                                      ? !isPlayer1Turn
                                      : isPlayer1Turn),
                              const SizedBox(height: 10),
                              PlayerAvatar(currentPlayer: opponent)
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children:
                                List.generate(opponent.hand.length, (index) {
                              final fanOffsetX = index * 20.0;
                              return Transform.translate(
                                offset: Offset(fanOffsetX, 0),
                                child: const Backside(),
                              );
                            }).toList(),
                          )
                        ],
                      ),

                      //draw pile and discard pile
                      SizedBox(
                        height: 150,
                        child: Row(
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
                                    : discardPile[discardPile.length - 1]
                                        .suit,
                                value: discardPile.isEmpty
                                    ? ""
                                    : discardPile[discardPile.length - 1]
                                        .rank)
                          ],
                        ),
                      ),

                      //player hand
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 160,
                            child: Stack(
                              alignment: Alignment.center,
                              children: List.generate(
                                  currentPlayer.hand.length, (index) {
                                final playedCard = currentPlayer.hand[index];
                                final fanOffsetX = index * 30.0;
                                final deckSize =
                                    currentPlayer.hand.length * 33;
                                return Positioned(
                                  left: ((width / 2) - (deckSize / 2)) +
                                      fanOffsetX,
                                  child: GestureDetector(
                                    onTap: () {
                                      CardModel discardCard =
                                          discardPile.isEmpty
                                              ? CardModel(suit: '', rank: '')
                                              : discardPile[
                                                  discardPile.length - 1];
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
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              PlayerAvatar(currentPlayer: currentPlayer),
                              const SizedBox(height: 10),
                              PlayerNameTag(
                                  name: currentPlayer.username,
                                  isTurn: currentUser.uid == player1.playerId
                                      ? isPlayer1Turn
                                      : !isPlayer1Turn),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
