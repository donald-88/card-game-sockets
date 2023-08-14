import 'package:flutter/material.dart';

class PlayingCard extends StatelessWidget {
  const PlayingCard({super.key, required this.suit, required this.value});

  final String suit;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: suit == '♥' || suit == '♦' || suit == '🂿'
                              ? Colors.red
                              : Colors.black)),
                  Text(suit,
                      style: TextStyle(
                          height: 1,
                          color: suit == '♥' || suit == '♦' || suit == '🂿'
                              ? Colors.red
                              : Colors.black)),
                ],
              ),
            ],
          ),
          Text(
            suit,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: suit == '♥' || suit == '♦' || suit == "🂿" ? Colors.red : Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: suit == '♥' || suit == '♦' || suit == "🂿"
                            ? Colors.red
                            : Colors.black),
                  ),
                  Text(
                    suit,
                    style: TextStyle(
                        color: suit == '♥' || suit == '♦' || suit == "🂿"
                            ? Colors.red
                            : Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
