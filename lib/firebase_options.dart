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
        return ios;
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
    apiKey: 'AIzaSyDzhL5VxItX5pNCKWm79Y70NYDbMnywGj4',
    appId: '1:382237870764:web:7c573cc4c9618c6e87ad09',
    messagingSenderId: '382237870764',
    projectId: 'multiplayer-card-game-mw',
    authDomain: 'multiplayer-card-game-mw.firebaseapp.com',
    databaseURL: 'https://multiplayer-card-game-mw-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'multiplayer-card-game-mw.appspot.com',
    measurementId: 'G-WY8F3SMQ7K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDa2jdVIShZSiB1mrUW2sb9B47KCppSpUM',
    appId: '1:382237870764:android:a91362547aabd43687ad09',
    messagingSenderId: '382237870764',
    projectId: 'multiplayer-card-game-mw',
    databaseURL: 'https://multiplayer-card-game-mw-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'multiplayer-card-game-mw.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAo4LTOI7ikGiDNtMcQ-sTz_ktnPFu-h6Y',
    appId: '1:382237870764:ios:d424f532314d75c087ad09',
    messagingSenderId: '382237870764',
    projectId: 'multiplayer-card-game-mw',
    databaseURL: 'https://multiplayer-card-game-mw-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'multiplayer-card-game-mw.appspot.com',
    iosClientId: '382237870764-khbn0dmar4al6cs1lo8bsb0rq3m0v2f8.apps.googleusercontent.com',
    iosBundleId: 'com.example.cardGameSockets',
  );
}
