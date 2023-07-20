import 'package:card_game_sockets/pages/waitingLobby.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

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
                    Text(Provider.of<RoomDataProvider>(context)
                        .player1
                        .playerId
                        .toString()),
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
                              return GestureDetector(
                                onTap: () {
                                  _socketMethods.playCard(
                                      index,
                                      "McDonald",
                                      roomDataProvider.roomData['_id'],
                                      roomDataProvider.roomData['players'][0]
                                          ['hand'][index],
                                      roomDataProvider.roomData['discardPile'][
                                          roomDataProvider
                                                  .roomData['discardPile']
                                                  .length -
                                              1],
                                      context);
                                },
                                child: SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: PlayingCard(
                                      suit: roomDataProvider.roomData['players']
                                          [0]['hand'][index]['suit'],
                                      value:
                                          roomDataProvider.roomData['players']
                                              [0]['hand'][index]['rank']),
                                ),
                              );
                            }),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Backside(),
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
                              return GestureDetector(
                                child: SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: PlayingCard(
                                      suit: roomDataProvider.roomData['players']
                                              [1]['hand'][index]['suit'] ??
                                          '',
                                      value:
                                          roomDataProvider.roomData['players']
                                                  [1]['hand'][index]['rank'] ??
                                              ''),
                                ),
                              );
                            }),
                      ),
                    ),
                    Text(Provider.of<RoomDataProvider>(context)
                        .player2
                        .playerId
                        .toString()),
                  ],
                ),
              ));
  }
}
