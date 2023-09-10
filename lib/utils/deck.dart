import 'package:card_game_sockets/models/cardModel.dart';

List<String> suits = ["w", "e", "r", "q"];
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
  "K",
  "Q",
  "A",
];
List<CardModel> deck = [];

List<CardModel> buildDeck() {
  for (String suit in suits) {
    for (String rank in ranks) {
      deck.add(CardModel(suit: suit, rank: rank));
    }
  }

  CardModel joker1 = CardModel(suit: "z", rank: "JOKER");
  CardModel joker2 = CardModel(suit: "c", rank: "JOKER");

  deck.add(joker1);
  deck.add(joker2);
  return deck;
}
