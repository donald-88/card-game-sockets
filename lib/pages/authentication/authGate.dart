import 'package:flutter/material.dart';

import '../lobby.dart';
import 'authWrapper.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const AuthWrapper();
        } else {
          return const Lobby();
        }
      },
    ));
  }
}
