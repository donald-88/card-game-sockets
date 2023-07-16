import 'socketClient.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String creatorId) {
    if(creatorId.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'creatorId': creatorId});
    }
  }
}