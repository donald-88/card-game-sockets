class RoomModel {
  String roomId;
  List<String> players;
  int turnIndex;
  List<String> drawPile;
  List<String> discardPile;
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

  factory RoomModel.fromJson(Map<String, dynamic> json){
      var playerObj = json['players'];
      var drawPileObj = json['drawPile'] ?? [];
      var discardPileObj = json['discardPile'] ?? [];
      return RoomModel(roomId : json['roomId'],
        players : List<String>.from(playerObj),
        turnIndex : json['turnIndex'],
        drawPile : List<String>.from(drawPileObj),
        discardPile : List<String>.from(discardPileObj),
        canJoin : json['canJoin']);
  }
}
