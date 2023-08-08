import 'package:card_game_sockets/services/roomService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Lobby extends StatefulWidget {
  const Lobby({super.key});

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  final TextEditingController _roomIdController = TextEditingController();

   final FirebaseAuth _auth = FirebaseAuth.instance;
   final RoomService _roomService = RoomService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void createRoom(){
    User? currentUser = _auth.currentUser;
    _roomService.createRoom(currentUser!.uid, context);
  }

  void joinRoom(){
    User? currentUser = _auth.currentUser;
    _roomService.joinRoom(currentUser!.uid, _roomIdController.text, context);
  }

  showJoinRoom(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Enter Room ID'),
      content: TextField(
        controller: _roomIdController,
      ),
      actions: [
        TextButton(onPressed: joinRoom, child: const Text('Join'))
      ],
    ));
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Test Create or Join a Game Server',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Create a game server and share the link with your friends or alternatively join a game server by entering the link provided by your friend',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(400, 50)),
                onPressed: createRoom,
                child: const Text('Create')),
            const SizedBox(height: 16),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(400, 50)),
                onPressed: showJoinRoom,
                child: const Text('Join')),
          ],
        ),
      ),
    );
  }
}
