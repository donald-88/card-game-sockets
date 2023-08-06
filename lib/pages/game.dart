import 'package:card_game_sockets/models/cardModel.dart';
import 'package:card_game_sockets/models/playerModel.dart';
import 'package:card_game_sockets/utils/deck.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/roomModel.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  DatabaseReference roomRef = FirebaseDatabase.instance.ref().child('rooms');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<CardModel> deck = [];

  void initializeGame(String roomId) async {
    deck = buildDeck();
    deck.shuffle();
    roomRef.child(roomId);
    final snapshot = await roomRef.get();
    if (snapshot.exists) {
      Map<String, dynamic> roomData = snapshot.value as Map<String, dynamic>;
      RoomModel roomModel = RoomModel.fromJson(roomData);
      for (var player in roomModel.players) {
        PlayerModel playerModel = PlayerModel.fromJson(player);
        for (int i = 0; i < 4; i++) {
          playerModel.hand.add(deck.removeLast());
        }
        player.putIfAbsent(
            'hand', () => playerModel.hand.map((e) => e.toJson()).toList());
      }
      roomModel.discardPile.add(deck.removeLast());
      roomModel.drawPile = deck;
      roomRef.set(roomModel.toJson());
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String roomId = ModalRoute.of(context)!.settings.arguments as String;
    initializeGame(roomId);
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
              children: []),
        ));
  }
}
