import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:scratcher/scratcher.dart';

import 'package:cardician_app_v2/card_class.dart';
import 'package:cardician_app_v2/custom_playing_card.dart';

class CardRevealer extends StatefulWidget {
  const CardRevealer({super.key});

  @override
  State<CardRevealer> createState() => _CardRevealerState();
}

class _CardRevealerState extends State<CardRevealer> {
  final _displayCard = MagicCard();
  bool isCardSelected = false;

  void selectCard(int index) {
    switch (index) {
      case 0:
        _displayCard.suit = Suit.clubs;
        _displayCard.value = CardValue.jack;
        break;
      case 1:
        _displayCard.suit = Suit.clubs;
        _displayCard.value = CardValue.queen;
        break;
      case 2:
        _displayCard.suit = Suit.clubs;
        _displayCard.value = CardValue.king;
        break;
      case 3:
        _displayCard.suit = Suit.hearts;
        _displayCard.value = CardValue.jack;
        break;
      case 4:
        _displayCard.suit = Suit.hearts;
        _displayCard.value = CardValue.queen;
        break;
      case 5:
        _displayCard.suit = Suit.hearts;
        _displayCard.value = CardValue.king;
        break;
      case 6:
        _displayCard.suit = Suit.spades;
        _displayCard.value = CardValue.jack;
        break;
      case 7:
        _displayCard.suit = Suit.spades;
        _displayCard.value = CardValue.queen;
        break;
      case 8:
        _displayCard.suit = Suit.spades;
        _displayCard.value = CardValue.king;
        break;
      case 9:
        _displayCard.suit = Suit.diamonds;
        _displayCard.value = CardValue.jack;
        break;
      case 10:
        _displayCard.suit = Suit.diamonds;
        _displayCard.value = CardValue.queen;
        break;
      case 11:
        _displayCard.suit = Suit.diamonds;
        _displayCard.value = CardValue.king;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //get entirescreen size

    return Scaffold(
      backgroundColor: Colors.black,
      body: Scratcher(
        brushSize: 100,
        onScratchUpdate: () => setState(() {
          isCardSelected = true;
        }),
        child: isCardSelected
            ? Center(
                child: CustomPlayingCard(
                    _displayCard.suit, _displayCard.value, false),
              )
            : GridView.count(
                crossAxisCount: 3,
                childAspectRatio: size.width / (size.height / 1.4),
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    12,
                    (index) => GestureDetector(
                          onTapDown: (tapDetails) {
                            selectCard(index);
                          },
                          child: Container(
                            color: Colors.black,
                          ),
                        ))),
      ),
    );
  }
}
