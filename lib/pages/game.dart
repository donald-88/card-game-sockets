import 'package:card_game_sockets/pages/waitingLobby.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/roomDataProvider.dart';
import '../resources/socketMethod.dart';
import '../widgets/backside.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.updateRoomListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
        backgroundColor: Colors.green.shade800,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.chat),
        ),
        body: roomDataProvider.roomData['canJoin']
            ? const WaitingLobby()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        Provider.of<RoomDataProvider>(context)
                            .player1
                            .playerId
                            .split('@')[0]
                            .toString(),
                        style: GoogleFonts.tourney(fontSize: 20)),
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: roomDataProvider
                                .roomData['players'][0]['hand'].length,
                            itemBuilder: (context, index) {
                              if (auth.currentUser!.email ==
                                  roomDataProvider.roomData['players'][0]
                                      ['playerId']) {
                                return GestureDetector(
                                  onTap: () {
                                    _socketMethods.playCard(
                                        index,
                                        0,
                                        Provider.of<RoomDataProvider>(context)
                                            .player1
                                            .playerId
                                            .toString(),
                                        roomDataProvider.roomData['turn'],
                                        roomDataProvider.roomData['_id'],
                                        roomDataProvider.roomData['players'][0]
                                            ['hand'][index],
                                        roomDataProvider.roomData['discardPile']
                                            [roomDataProvider
                                                    .roomData['discardPile']
                                                    .length -
                                                1],
                                        context);
                                  },
                                  child: SizedBox(
                                    height: 150,
                                    width: 100,
                                    child: PlayingCard(
                                        suit:
                                            roomDataProvider.roomData['players']
                                                [0]['hand'][index]['suit'],
                                        value:
                                            roomDataProvider.roomData['players']
                                                [0]['hand'][index]['rank']),
                                  ),
                                );
                              } else{
                                return const Backside();
                              }
                            }),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _socketMethods.pickCard(
                                  roomDataProvider.roomData['players'][1]
                                      ['playerId'],
                                  roomDataProvider.roomData['_id']);
                            },
                            child: const Backside()),
                        const SizedBox(
                          width: 100,
                        ),
                        PlayingCard(
                            suit: roomDataProvider.roomData['discardPile'][
                                roomDataProvider
                                        .roomData['discardPile'].length -
                                    1]['suit'],
                            value: roomDataProvider.roomData['discardPile'][
                                roomDataProvider
                                        .roomData['discardPile'].length -
                                    1]['rank'])
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: roomDataProvider
                                    .roomData['players'][1]['hand'].length ??
                                0,
                            itemBuilder: (context, index) {
                             if (auth.currentUser!.email ==
                                  roomDataProvider.roomData['players'][1]
                                      ['playerId']) {
                                return GestureDetector(
                                  onTap: () {
                                    _socketMethods.playCard(
                                        index,
                                        1,
                                        Provider.of<RoomDataProvider>(context)
                                            .player1
                                            .playerId
                                            .toString(),
                                        roomDataProvider.roomData['turn'],
                                        roomDataProvider.roomData['_id'],
                                        roomDataProvider.roomData['players'][1]
                                            ['hand'][index],
                                        roomDataProvider.roomData['discardPile']
                                            [roomDataProvider
                                                    .roomData['discardPile']
                                                    .length -
                                                1],
                                        context);
                                  },
                                  child: SizedBox(
                                    height: 150,
                                    width: 100,
                                    child: PlayingCard(
                                        suit:
                                            roomDataProvider.roomData['players']
                                                [1]['hand'][index]['suit'],
                                        value:
                                            roomDataProvider.roomData['players']
                                                [1]['hand'][index]['rank']),
                                  ),
                                );
                              } else{
                                return const Backside();
                              }
                            }),
                      ),
                    ),
                    Text(
                      Provider.of<RoomDataProvider>(context)
                          .player2
                          .playerId
                          .split('@')[0]
                          .toString(),
                      style: GoogleFonts.tourney(fontSize: 20),
                    ),
                  ],
                ),
              ));
  }
}
