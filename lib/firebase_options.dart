// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBOIefMtGjPzi6b39YE4nGwbEG-aGxHZdo',
    appId: '1:168442241897:web:c131ab89655b92abda13f8',
    messagingSenderId: '168442241897',
    projectId: 'card-game-4fe5e',
    authDomain: 'card-game-4fe5e.firebaseapp.com',
    storageBucket: 'card-game-4fe5e.appspot.com',
    measurementId: 'G-CSXB57BYFD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBDHMT4G7akJYdk7pGotvEelrHm0FzCprA',
    appId: '1:168442241897:android:a29b80f570bd751eda13f8',
    messagingSenderId: '168442241897',
    projectId: 'card-game-4fe5e',
    storageBucket: 'card-game-4fe5e.appspot.com',
  );
}