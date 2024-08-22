import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/material.dart';

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

CardValue inputValue(BuildContext context) {
  CardValue inputValue = CardValue.joker_1;

  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            13,
            (index) => TextButton(
                  child: Text(
                    '${valueMap[valList[index]]}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontFamily: 'Georgia'),
                  ),
                  onPressed: () {
                    inputValue = valList[index];
                    Navigator.of(context).pop();
                  },
                )),
      ),
    ),
  );

  return inputValue;
}

Suit inputSuit(BuildContext context) {
  Suit inputSuit = Suit.joker;

  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          4,
          (index) => IconButton(
            icon: const Icon(Icons.man),
            onPressed: () {
              inputSuit = suitList[index];
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    ),
  );

  return inputSuit;
}
