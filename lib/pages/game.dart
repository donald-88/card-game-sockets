import 'package:card_game_sockets/utils/deck.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/roomModel.dart';

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

  late String roomId;
  List<PlayingCard> deck = [];

  void initializeGame() async{
    deck = buildDeck();
    deck.shuffle();
    for(var card in deck){
      print("${card.suit} ${card.value}");
    }
    DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms').child(roomId);
      final snapshot = await roomRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> roomData = snapshot.value as Map<String, dynamic>;
        RoomModel roomModel = RoomModel.fromJson(roomData);
        for(var player in roomModel.players){
          player['hand'
        }
      } else {
        print('No data available.');
      }
  }

  @override
  Widget build(BuildContext context) {  
    roomId = ModalRoute.of(context)!.settings.arguments as String;
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
