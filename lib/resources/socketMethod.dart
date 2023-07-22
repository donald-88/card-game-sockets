import 'package:card_game_sockets/utils/validator.dart';
import 'package:card_game_sockets/widgets/mySnackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/roomDataProvider.dart';
import 'socketClient.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String creatorId) {
    if (creatorId.isNotEmpty) {
      _socketClient.emit('createRoom', {'creatorId': creatorId});
    }
  }

  joinRoom(String roomId, String playerId) {
    if (roomId.isNotEmpty && playerId.isNotEmpty) {
      _socketClient.emit('joinRoom', {'roomId': roomId, 'playerId': playerId});
    }
  }

/////////////////////////////////////////////////////////////
////////////////////Listeners////////////////////////////////
/////////////////////////////////////////////////////////////

  void roomCreatedListener(BuildContext context) {
    _socketClient.on('roomCreated', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, '/game');
    });
  }

  void joinRoomListener(BuildContext context) {
    _socketClient.on('roomJoined', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, '/game');
    });
  }

  void errorOcurred(BuildContext context) {
    _socketClient.on('errorOccured', (error) {
      showSnackBar(context, error);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (players) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(players[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(players[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
    });
  }

  /////////////////////////////////////////////////////////////////
  ////////////////////In-Game Functions////////////////////////////
  ////////////////////////////////////////////////////////////////

  void playCard(
      int index,
      int playerIndex,
      String playerId,
      int turn,
      String roomId,
      Map<String, dynamic> card,
      Map<String, dynamic> topCard,
      context) {
    if (checkTurn(playerIndex, turn)) {
      if (cardValidator(card, topCard)) {
        _socketClient.emit('playCard', {
          'index': index,
          'roomId': roomId,
          'playerId': playerId,
        });
      } else {
        showSnackBar(context, 'Invalid Card');
      }
    } else {
      showSnackBar(context, 'Not your turn');
    }
  }

  void pickCard(String playerId, String roomId) {
    _socketClient.emit('pickCard', {
      'playerId': playerId,
      'roomId': roomId,
    });
  }

  void pickSuiteListener(BuildContext context) {
    _socketClient.on("pickSuite", (player) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(player);
      showAboutDialog(context: context);
    });
  }
}
