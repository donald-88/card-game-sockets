import 'package:card_game_sockets/models/playerModel.dart';
import 'package:card_game_sockets/models/roomModel.dart';
import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:card_game_sockets/widgets/backside.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> player1 = {};
  Map<String, dynamic> player2 = {};
  List discardPile = [];
  int turn = 0;

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;
    final String roomId = ModalRoute.of(context)!.settings.arguments as String;
    DatabaseReference roomRef =
        FirebaseDatabase.instance.ref().child('rooms').child(roomId);

    roomRef.onValue.listen((event) {
      Map<String, dynamic> data = event.snapshot.value as Map<String, dynamic>;
      setState(() {
        player1 = data['players'][0];
        player2 = data['players'][1];
        discardPile = data['discardPile'];
        turn = data['turnIndex'];
      });
    });
    return Scaffold(
        backgroundColor: Colors.green.shade800,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Center(
                      child: FirebaseAnimatedList(
                          query: roomRef,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, snapshot,
                              animation, index) {
                            if (snapshot.exists) {
                              Map<String, dynamic> room =
                                  snapshot.value as Map<String, dynamic>;
                              RoomModel roomModel = RoomModel.fromJson(room);
                              Map<String, dynamic> player =
                                  roomModel.players as Map<String, dynamic>;
                              PlayerModel playerModel =
                                  PlayerModel.fromJson(player[0]);
                              return const PlayingCard(suit: '', value: '');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          })),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => pickCard(roomId), child: const Backside()),
                    const SizedBox(width: 100),
                    PlayingCard(
                        suit: discardPile[discardPile.length - 1]['suit'],
                        value: discardPile[discardPile.length - 1]['rank'])
                  ],
                ),
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: player2['hand'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (currentUser!.uid == player2['playerId']) {
                            return GestureDetector(
                              onTap: () => playCard(roomId, index, 1),
                              child: PlayingCard(
                                  suit:
                                      player2['hand'][index]['suit'].toString(),
                                  value: player2['hand'][index]['rank']
                                      .toString()),
                            );
                          } else {
                            return const Backside();
                          }
                        }),
                  ),
                ),
              ]),
        ));
  }
}
