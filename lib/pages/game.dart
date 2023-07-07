import 'package:flutter/material.dart';

import '../widgets/backside.dart';
import '../widgets/playingCard.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade800,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.chat),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayingCard(),
                  PlayingCard(),
                ],
              ),
              Backside(),
              Row(
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
