import 'package:playing_cards/playing_cards.dart';

class MyCard {
  Suit suit = Suit.joker;
  CardValue value = CardValue.joker_1;
  bool showBack = true;

  //Constructor to initialize card parameters
  MyCard(this.suit, this.value, this.showBack);
}

final Map valueMap = {
  CardValue.ace: 'A',
  CardValue.two: '2',
  CardValue.three: '3',
  CardValue.four: '4',
  CardValue.five: '5',
  CardValue.six: '6',
  CardValue.seven: '7',
  CardValue.eight: '8',
  CardValue.nine: '9',
  CardValue.ten: '10',
  CardValue.jack: 'J',
  CardValue.queen: 'Q',
  CardValue.king: 'K'
};

final Map suitMap = {
  Suit.clubs: 'club',
  Suit.hearts: 'heart',
  Suit.spades: 'spade',
  Suit.diamonds: 'diamond'
};

final List valList = valueMap.keys.toList();
final List suitList = suitMap.keys.toList();
