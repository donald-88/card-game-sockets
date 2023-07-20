bool cardValidator(Map<String, dynamic> card, Map<String, dynamic> topCard) {
  if (card['suit'] == topCard['suit'] || card['rank'] == topCard['rank']) {
    return true;
  }else{
    return false;
  }
}

bool checkTurn(String playerId, int turn) {
  if (playerId == turn) {
    return true;
  } else {
    return false;
  }
}