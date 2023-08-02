class RoomModel {
  String roomId;
  List players;
  int turnIndex;
  List drawPile;
  List discardPile;
  bool canJoin;

  RoomModel(
      {required this.roomId,
      required this.players,
      required this.turnIndex,
      required this.drawPile,
      required this.discardPile,
      required this.canJoin});

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'players': players,
        'turnIndex': turnIndex,
        'drawPile': drawPile,
        'discardPile': discardPile,
        'canJoin': canJoin
      };

  RoomModel.fromJson(Map<String, dynamic> json)
      : roomId = json['roomId'],
        players = json['players'],
        turnIndex = json['turnIndex'],
        drawPile = json['drawPile'],
        discardPile = json['discardPile'],
        canJoin = json['canJoin'];
}
