import 'package:flutter/material.dart';

class RoomProvider with ChangeNotifier {
  String? roomData;

  void updateRoomData(String data) {
    roomData = data;
    notifyListeners();
  }
}
