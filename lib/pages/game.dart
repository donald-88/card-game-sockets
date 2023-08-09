import 'package:card_game_sockets/models/playerModel.dart';
import 'package:card_game_sockets/models/roomModel.dart';
import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:card_game_sockets/widgets/backside.dart';
import 'package:card_game_sockets/widgets/forfeitDialog.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
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
      setState(() {
        discardPile = roomModel.discardPile;
        player1 = player1Model;
        player2 = player2Model;
        turn = roomModel.turnIndex;
        winner = roomModel.winner;
        playerWon = roomModel.playerWon;
      });
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<CardModel> discardPile = [];
  int turn = 0;
  PlayerModel player1 = PlayerModel(playerId: '', roomId: '', hand: []);
  PlayerModel player2 = PlayerModel(playerId: '', roomId: '', hand: []);
  bool winner = false;
  String playerWon = '';

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;
    if (winner) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Winner"),
                content: Text("Player $playerWon won!!"),
              ));
    }
    return Scaffold(
        backgroundColor: Colors.green.shade800,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              backgroundColor: Colors.red,
                onPressed: () => showForfeitDialog(context), child: const Icon(Icons.exit_to_app, color: Colors.white,)),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              backgroundColor: Colors.red,
                onPressed: () {}, child: Text('15', style: Theme.of(context).textTheme.bodyLarge,)),
          ],
        ),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/background.jpeg'))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PlayerNameTag(
                    name: 'Player1',
                  ),
                  SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: player1.hand.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (currentUser!.uid == player1.playerId) {
                                CardModel playedCard = player1.hand[index];
                                return GestureDetector(
                                  onTap: () => playCard(
                                      widget.roomId,
                                      playedCard,
                                      discardPile.isEmpty
                                          ? CardModel(suit: '', rank: '')
                                          : discardPile[discardPile.length - 1],
                                      0,
                                      turn,
                                      context),
                                  child: PlayingCard(
                                      suit: player1.hand[index].suit,
                                      value: player1.hand[index].rank),
                                );
                              } else {
                                return const Backside();
                              }
                            }),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () => pickCard(widget.roomId),
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
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: player2.hand.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (currentUser!.uid == player2.playerId) {
                              CardModel playedCard = player2.hand[index];
                              return GestureDetector(
                                onTap: () => playCard(
                                    widget.roomId,
                                    playedCard,
                                    discardPile.isEmpty
                                        ? CardModel(suit: '', rank: '')
                                        : discardPile[discardPile.length - 1],
                                    1,
                                    turn,
                                    context),
                                child: PlayingCard(
                                    suit: player2.hand[index].suit,
                                    value: player2.hand[index].rank),
                              );
                            } else {
                              return const Backside();
                            }
                          }),
                    ),
                  ),
                  const PlayerNameTag(
                    name: 'Player2',
                  ),
                ]),
          ),
        ));
  }
}
