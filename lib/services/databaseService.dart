import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('rooms');

  Future<Map<String, dynamic>?> getRoomData(String roomId) async {
    final snapShot = await _databaseReference.child(roomId).get();
    if (snapShot.exists) {
      return snapShot.value as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> updateRoomData(
      String roomId, Map<String, dynamic> roomData) async {
    await _databaseReference.child(roomId).set(roomData);
  }
}
