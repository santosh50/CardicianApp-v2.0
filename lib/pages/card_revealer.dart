import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:scratcher/scratcher.dart';

import 'package:cardician_app_v2/card_class.dart';
import 'package:cardician_app_v2/widgets/custom_playing_card.dart';

class CardRevealer extends StatefulWidget {
  const CardRevealer({super.key});

  @override
  State<CardRevealer> createState() => _CardRevealerState();
}

class _CardRevealerState extends State<CardRevealer> {
  final _myCard = MagicCard();
  bool isCardSelected = false;

  void selectCard(int index) {
    switch (index) {
      case 0:
        _myCard.suit = Suit.clubs;
        _myCard.value = CardValue.jack;
        break;
      case 1:
        _myCard.suit = Suit.clubs;
        _myCard.value = CardValue.queen;
        break;
      case 2:
        _myCard.suit = Suit.clubs;
        _myCard.value = CardValue.king;
        break;
      case 3:
        _myCard.suit = Suit.hearts;
        _myCard.value = CardValue.jack;
        break;
      case 4:
        _myCard.suit = Suit.hearts;
        _myCard.value = CardValue.queen;
        break;
      case 5:
        _myCard.suit = Suit.hearts;
        _myCard.value = CardValue.king;
        break;
      case 6:
        _myCard.suit = Suit.spades;
        _myCard.value = CardValue.jack;
        break;
      case 7:
        _myCard.suit = Suit.spades;
        _myCard.value = CardValue.queen;
        break;
      case 8:
        _myCard.suit = Suit.spades;
        _myCard.value = CardValue.king;
        break;
      case 9:
        _myCard.suit = Suit.diamonds;
        _myCard.value = CardValue.jack;
        break;
      case 10:
        _myCard.suit = Suit.diamonds;
        _myCard.value = CardValue.queen;
        break;
      case 11:
        _myCard.suit = Suit.diamonds;
        _myCard.value = CardValue.king;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //get entirescreen size

    return Scaffold(
      backgroundColor: Colors.black,
      body: Scratcher(
        brushSize: 70,
        onScratchUpdate: () => setState(() {
          isCardSelected = true;
        }),
        child: isCardSelected
            ? Center(
                child: CustomPlayingCard(_myCard.suit, _myCard.value, true),
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
