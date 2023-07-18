import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/roomDataProvider.dart';
import '../widgets/backside.dart';
import '../widgets/playingCard.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    print(Provider.of<RoomDataProvider>(context).player1.toString());
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
