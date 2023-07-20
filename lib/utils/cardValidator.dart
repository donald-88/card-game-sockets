bool cardValidator(Map<String, dynamic> card, Map<String, dynamic> topCard) {
  if (card['suit'] == topCard['suit'] || card['rank'] == topCard['rank']) {
    return true;
  }else{
    return false;
  }
}
