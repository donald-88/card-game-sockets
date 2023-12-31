import 'dart:math';

import 'package:card_game_sockets/pages/authentication/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:flutter/material.dart';
import '../widgets/customDialog.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String pickAvatar() {
    List<String> avatars = [
      'assets/avatars/avatar_1.png',
      'assets/avatars/avatar_2.png',
      'assets/avatars/avatar_3.png',
      'assets/avatars/avatar_4.png',
      'assets/avatars/avatar_5.png',
      'assets/avatars/avatar_6.png',
      'assets/avatars/avatar_7.png',
      'assets/avatars/avatar_8.png',
      'assets/avatars/avatar_9.png',
      'assets/avatars/avatar_10.png',
      'assets/avatars/avatar_11.png'
    ];

    return avatars[Random().nextInt(avatars.length)];
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future signInWithPhoneNumber(String phone, String password) async {
    try {
      ConfirmationResult confirmationResult = await _auth.signInWithPhoneNumber(
          phone,
          RecaptchaVerifier(
              auth: FirebaseAuthWeb.instance,
              container: 'recaptcha',
              size: RecaptchaVerifierSize.compact,
              theme: RecaptchaVerifierTheme.dark));

      return confirmationResult;
    } catch (e) {
      return null;
    }
  }

  Future registerWithPhoneNumber(
      String username, String phone, String password, context) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            showCustomDialog(context, 'error', 'Invalid Phone Number', e.code);
          } else {
            Navigator.pop(context);
            showCustomDialog(context, 'error', 'Error',
                "Error, something went wrong try again");
          }
        },
        codeSent: (verificationId, resendToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OTPPage(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  Future verifyOTP(
      BuildContext context, String verificationId, String userOTP) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);

      User user = (await _auth.signInWithCredential(creds)).user!;

      return user;
    } catch (e) {
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      result.user!.updateDisplayName(username);
      String photoURL = pickAvatar();
      result.user!.updatePhotoURL(photoURL);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
