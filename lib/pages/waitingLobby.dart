import 'package:flutter/material.dart';

class WaitingLobby extends StatelessWidget {
  const WaitingLobby({super.key});

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
          Text('Waiting for other players to connect.', style: Theme.of(context).textTheme.headlineMedium),
        ],
      )
    );
  }
}