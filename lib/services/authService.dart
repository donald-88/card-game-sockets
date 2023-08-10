import 'package:card_game_sockets/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // register with email and password
  Future registerWithEmailAndPassword(
      String username, String email, String password) async {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child('users');
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userRef.child(_auth.currentUser!.uid)
          .set(UsersModel(username: username, userId: _auth.currentUser!.uid).toJson());
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
