import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/roomDataProvider.dart';
import '../resources/socketMethod.dart';
import '../widgets/backside.dart';
import '../widgets/playingCard.dart';

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
    print(Provider.of<RoomDataProvider>(context).roomData.toString());
    return Scaffold(
        backgroundColor: Colors.green.shade800,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.chat),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Provider.of<RoomDataProvider>(context).player1.toString()),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayingCard(),
                  PlayingCard(),
                ],
              ),
              const Backside(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayingCard(),
                  PlayingCard(),
                ],
              ),
            ],
          ),
        ));
  }
}
