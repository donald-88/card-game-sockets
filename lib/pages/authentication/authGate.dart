import 'package:card_game_sockets/pages/authentication/emailVerfication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../lobby.dart';
import 'authWrapper.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User? user = snapshot.data;
          if (user != null) {
            if(user.phoneNumber != null){
              return const Lobby();
            }
            if(user.emailVerified){
              return const Lobby();
            }
            if(!user.emailVerified){
              return const EmailVerification();
            }
            else{
              return const AuthWrapper();
            }
          } else {
            return const AuthWrapper();
          }
        } else {
          return const AuthWrapper();
        }
      },
    );
  }
}
