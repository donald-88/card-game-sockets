import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:flutter/material.dart';

List<String> pickCard = ["♣", "♦", "♥", "♠"];

Future<dynamic> showAceDialog(context, String roomId) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pick A Suite"),
              ],
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height/3,
              width: 300,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .8,
                      crossAxisCount: 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => playAce(roomId, pickCard[index]),
                        child: SizedBox(
                          width: 100,
                          height: 150,
                          child: PlayingCard(suit: pickCard[index], value: '')));
                  }),
            ));
      });
}
