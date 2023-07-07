import 'package:flutter/material.dart';

class Backside extends StatelessWidget {
  const Backside({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: const DecorationImage(
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
            image: AssetImage('assets/backside.jpg')),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
