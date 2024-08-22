import 'package:playing_cards/playing_cards.dart';

class MagicCard {
  Suit suit = Suit.joker;
  CardValue value = CardValue.joker_1;
  bool showBack = true;
}

final Map<CardValue, String> valueMap = {
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

final Map<Suit, String> suitMap = {
  Suit.clubs: 'club',
  Suit.hearts: 'heart',
  Suit.spades: 'spade',
  Suit.diamonds: 'diamond'
};

final valList = valueMap.keys.toList();
final suitList = suitMap.keys.toList();
