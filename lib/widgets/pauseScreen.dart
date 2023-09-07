import 'dart:async';
import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:card_game_sockets/widgets/slideFadeInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatefulWidget {
  final String roomId;
  final String playerPauseId;
  const PauseMenu(
      {super.key, required this.roomId, required this.playerPauseId});

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
  @override
  void initState() {
    // TODO: implement initState
    startCounter();
    super.initState();
  }

  int timeLeft = 60;

  void startCounter() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        if (mounted) {
          setState(() {
            timeLeft--;
          });
        }
      } else {
        timer.cancel();
        onGameResume(widget.roomId);
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SlideFadeInPage(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('The game will automatically resume in $timeLeft seconds.'),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  if (widget.playerPauseId == _auth.currentUser?.uid) {
                    onGameResume(widget.roomId);
                  }
                },
                child: Text("R E S U M E",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white.withOpacity(
                            widget.playerPauseId == _auth.currentUser?.uid
                                ? 1
                                : .5)))),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {},
                child: Text("S T A K E",
                    style: Theme.of(context).textTheme.headlineMedium)),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {},
                child: Text("H E L P",
                    style: Theme.of(context).textTheme.headlineMedium))
          ],
        ),
      ),
    );
  }
}
