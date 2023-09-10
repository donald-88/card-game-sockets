import 'dart:math';

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
            color: Colors.black.withOpacity(0.3),
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
                          color: suit == 'r' || suit == 'e' || suit == 'c'
                              ? Colors.red
                              : Colors.black)),
                  Text(suit,
                      style: TextStyle(
                          height: .8,
                          fontSize: 24,
                          wordSpacing: 1,
                          fontFamily: 'Hoyle',
                          textBaseline: TextBaseline.ideographic,
                          color: suit == 'r' || suit == 'e' || suit == 'c'
                              ? Colors.red
                              : Colors.black)),
                ],
              ),
            ],
          ),
          Text(
            suit,
            style: TextStyle(
                fontSize: 52,
                height: .8,
                fontFamily: 'Hoyle',
                fontWeight: FontWeight.bold,
                color: suit == 'r' || suit == 'e' || suit == "c"
                    ? Colors.red
                    : Colors.black),
          ),
          Transform.rotate(
            angle: pi,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: suit == 'r' || suit == 'e' || suit == "c"
                              ? Colors.red
                              : Colors.black),
                    ),
                    Text(
                      suit,
                      style: TextStyle(
                          height: .8,
                          fontSize: 24,
                          fontFamily: 'Hoyle',
                          color: suit == 'r' || suit == 'e' || suit == "c"
                              ? Colors.red
                              : Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
