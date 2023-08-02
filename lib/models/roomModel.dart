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
}
