import 'package:card_game_sockets/models/cardModel.dart';

class PlayerModel {
  String playerId;
  String roomId;
  String username;
  String avatar;
  bool knock;
  int pauseCount;
  List<CardModel> hand;

  PlayerModel(
      {required this.playerId,
      required this.roomId,
      required this.username,
      required this.avatar,
      required this.knock,
      required this.pauseCount,
      required this.hand});

  Map<String, dynamic> toJson() => {
        'playerId': playerId,
        'roomId': roomId,
        'username': username,
        'avatar': avatar,
        'knock': knock,
        'pauseCount': pauseCount,
        'hand': hand.map((e) => e.toJson()).toList(),
      };

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    var handObj = json['hand'] ?? [];
    return PlayerModel(
        playerId: json['playerId'],
        roomId: json['roomId'],
        username: json['username'],
        avatar: json['avatar'],
        knock: json['knock'],
        pauseCount: json['pauseCount'],
        hand: List<CardModel>.from(handObj.map((x) => CardModel.fromJson(x))));
  }
}
