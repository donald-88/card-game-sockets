import 'dart:async';

import 'package:card_game_sockets/pages/lobby.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  Timer? timer;

  bool isEmailVerified = false;

  @override
  void initState() {
    // TODO: implement initState
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerification());
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  Future checkEmailVerification() async {
    print('Not verified');
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return isEmailVerified ? const Lobby() : Scaffold(
      appBar: AppBar(),
        body: Center(
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email_outlined, size: 70),
            const SizedBox(height: 20),
            Text('Email Verification',
                style: width > 375
                    ? Theme.of(context).textTheme.titleLarge
                    : Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Text(
                "A verification link has been sent to your email. Please verify your email to continue",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            const Text(
                'If not autoredirected after verification, click on the continue button',
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(400, 50)),
                onPressed: () {
                  FirebaseAuth.instance.currentUser!.reload();
                },
                child: Text('Continue',
                    style: width > 375
                        ? Theme.of(context).textTheme.labelLarge
                        : Theme.of(context).textTheme.labelMedium)),
          ],
        ),
      ),
    ));
  }
}
