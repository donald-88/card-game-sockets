import 'package:card_game_sockets/pages/waitingLobby.dart';
import 'package:card_game_sockets/utils/gameFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/roomDataProvider.dart';
import '../resources/socketMethod.dart';
import '../utils/deck.dart';
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
    shuffleDeck();
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
        body: roomDataProvider.roomData['canJoin'] ? const WaitingLobby(): Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Provider.of<RoomDataProvider>(context).player1.playerId.toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  deck[0],
                  deck[24],
                ],
              ),
              const Backside(),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  deck[50],
                  deck[51]
                ],
              ),
              Text(Provider.of<RoomDataProvider>(context).player2.playerId.toString()),
            ],
          ),
        ));
  }
}
