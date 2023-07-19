import 'deck.dart';

void initializeGame(){}


void shuffleDeck(){
  deck.shuffle();
}

void dealCards(player1Hand, player2Hand){
  for(int i = 0; i < 7; i++){
    player1Hand.add(deck.removeLast());
    player2Hand.add(deck.removeLast());
  }
}

void setupDrawPile(){}
void playCard(){
}

void drawCard(){

}