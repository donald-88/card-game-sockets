import 'package:flutter/material.dart';

class PlayerNameTag extends StatelessWidget {
  final String name;
  final bool isTurn;
  const PlayerNameTag({
    super.key,
    required this.name,
    required this.isTurn
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.orangeAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.orangeAccent.withOpacity(isTurn? 0.6: 0),
            spreadRadius: 1,
            blurRadius: 16,
            offset: const Offset(-8, 0)
          ),
           BoxShadow(
            color: Colors.orangeAccent.withOpacity(isTurn? 0.6: 0),
            spreadRadius: 1,
            blurRadius: 16,
            offset: const Offset(8, 0)
          )
        ]
      ),
      duration: const Duration(milliseconds: 200),
      child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold),));
  }
}
