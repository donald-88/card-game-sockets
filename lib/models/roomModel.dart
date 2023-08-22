import 'package:card_game_sockets/models/cardModel.dart';

class RoomModel {
  String roomId;
  List<Map<String, dynamic>> players;
  int turnIndex;
  List<CardModel> drawPile;
  List<CardModel> discardPile;
  bool canJoin;
  bool isWon;
  bool isPaused;
  String playerPauseId;
  bool isForfeitWin;
  String playerWon;

  RoomModel({
    required this.roomId,
    required this.players,
    required this.turnIndex,
    required this.drawPile,
    required this.discardPile,
    required this.canJoin,
    required this.isWon,
    required this.isPaused,
    required this.playerPauseId,
    required this.isForfeitWin,
    required this.playerWon,
  });

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'players': players,
        'turnIndex': turnIndex,
        'drawPile': drawPile.map((e) => e.toJson()).toList(),
        'discardPile': discardPile.map((e) => e.toJson()).toList(),
        'canJoin': canJoin,
        'isWon': isWon,
        'isPaused': isPaused,
        'playerPauseId': playerPauseId,
        'isForfeitWin': isForfeitWin,
        'playerWon': playerWon,
      };

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    var playerObj = json['players'];
    var drawPileObj = json['drawPile'] ?? [];
    var discardPileObj = json['discardPile'] ?? [];
    return RoomModel(
        roomId: json['roomId'],
        players: List<Map<String, dynamic>>.from(playerObj),
        turnIndex: json['turnIndex'],
        drawPile:
            List<CardModel>.from(drawPileObj.map((x) => CardModel.fromJson(x))),
        discardPile: List<CardModel>.from(
            discardPileObj.map((x) => CardModel.fromJson(x))),
        canJoin: json['canJoin'],
        isWon: json['isWon'],
        isPaused: json['isPaused'],
        playerPauseId: json['playerPauseId'],
        isForfeitWin: json['isForfeitWin'],
        playerWon: json['playerWon'],);
  }
}
