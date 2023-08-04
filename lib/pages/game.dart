import 'package:card_game_sockets/pages/waitingLobby.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/playingCard.dart';

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

  bool join = false;

  @override
  Widget build(BuildContext context) {
    final String roomId = ModalRoute.of(context)!.settings.arguments as String;
    final DatabaseReference roomRef =
        FirebaseDatabase.instance.ref().child('rooms/$roomId');

    roomRef.onValue.listen((event) {
      Map<String, dynamic> data = event.snapshot.value as Map<String, dynamic>;
      setState(() {
        join = data['canJoin'] ?? false;
      });
    });
    
    return Scaffold(
        backgroundColor: Colors.green.shade800,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.chat),
        ),
        body: join
            ? WaitingLobby(roomId: roomId)
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(itemBuilder: (context, index) {
                      return const PlayingCard(suit: '', value: '');
                    })
                  ],
                ),
              ));
  }
}
