import 'package:flutter/material.dart';

import '../models/playerModel.dart';

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({
    super.key,
    required this.currentPlayer,
  });

  final PlayerModel currentPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.orangeAccent),
      padding: const EdgeInsets.all(3),
      child: CircleAvatar(
        radius: 24,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
              currentPlayer.avatar != ''
                  ? currentPlayer.avatar
                  : 'assets/avatars/placeholder.png',
              fit: BoxFit.contain),
        ),
      ),
    );
  }
}
