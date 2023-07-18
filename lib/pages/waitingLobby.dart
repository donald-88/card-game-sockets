import 'package:card_game_sockets/provider/roomDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WaitingLobby extends StatelessWidget {
  const WaitingLobby({super.key});

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          const CircularProgressIndicator(),
          const SizedBox(height: 20,),
          Text('Waiting for other players to join...', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height:16),
          Text('RoomId: ${roomDataProvider.roomData['_id'].toString()}', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: (){
            final data = ClipboardData(text: roomDataProvider.roomData['_id'].toString());
            Clipboard.setData(data);}, child: const Text('Copy Room ID'))
        ],
      )
    );
  }
}