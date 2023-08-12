import 'package:card_game_sockets/models/cardModel.dart';

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
List<CardModel> deck = [];

List<CardModel> buildDeck() {
  for (String suit in suits) {
    for (String rank in ranks) {
      deck.add(CardModel(suit: suit, rank: rank));
    }
  }

  CardModel joker = CardModel(suit: "", rank: "JOKER");

  deck.add(joker);
  deck.add(joker);
  return deck;
}
