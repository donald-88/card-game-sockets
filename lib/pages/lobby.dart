import 'package:flutter/material.dart';

class Lobby extends StatefulWidget {
  const Lobby({super.key});

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
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
              'Create or Join a Game Server',
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
                onPressed: () {},
                child: const Text('Create')),
            const SizedBox(height: 16),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(400, 50)),
                onPressed: () {},
                child: const Text('Join')),
          ],
        ),
      ),
    );
  }
}
