import 'package:card_game_sockets/utils/deck.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
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
    initializeGame();
  }
  List<PlayingCard> deck = [];

  void initializeGame(){
    deck = buildDeck();
    deck.shuffle();
    
  }

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
                  children: []
                ),
              ));
  }
}
