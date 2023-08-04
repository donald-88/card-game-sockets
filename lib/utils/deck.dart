import 'package:card_game_sockets/widgets/playingCard.dart';

List<String> suits = ["♣", "♦", "♥", "♠"];
List<String> ranks = [
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "J",
  "Q",
  "K",
  "A",
];
List<PlayingCard> deck = [];

List<PlayingCard> buildDeck() {
  for (String suit in suits) {
    for (String rank in ranks) {
      deck.add(PlayingCard(suit: suit, value: rank));
    }
  }
  return deck;
}
