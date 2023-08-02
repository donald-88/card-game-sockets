import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WaitingLobby extends StatelessWidget {

  final String roomId;
  const WaitingLobby({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
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
          Text('RoomId: $roomId', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: (){
            ClipboardData data = ClipboardData(text: roomId);
            Clipboard.setData(data);}, child: const Text('Copy Room ID'))
        ],
      )
    );
  }
}