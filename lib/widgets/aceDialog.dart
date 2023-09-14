import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:flutter/material.dart';

List<String> pickCard = ["w", "e", "r", "q"];

Future<dynamic> showAceDialog(context, String roomId) {
  return showDialog(
      barrierDismissible: false,
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
              height: 100,
              width: 320,
              child: Center(
                child: GridView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.7,
                            crossAxisCount: 1,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            playAce(roomId, pickCard[index]);
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 80,
                            width: 50,
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
                            child: Center(
                              child: Text(pickCard[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                          fontSize: 32,
                                          fontFamily: 'Hoyle',
                                          color: pickCard[index] == 'r' ||
                                                  pickCard[index] == 'e'
                                              ? Colors.red
                                              : Colors.black)),
                            ),
                          ));
                    }),
              ),
            ));
      });
}
