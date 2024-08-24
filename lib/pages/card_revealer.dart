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
  final myCard = MagicCard();
  bool isCardSelected = false;

  void selectCard(int index) {
    switch (index) {
      case 0:
        myCard.suit = Suit.clubs;
        myCard.value = CardValue.jack;
        break;
      case 1:
        myCard.suit = Suit.clubs;
        myCard.value = CardValue.queen;
        break;
      case 2:
        myCard.suit = Suit.clubs;
        myCard.value = CardValue.king;
        break;
      case 3:
        myCard.suit = Suit.hearts;
        myCard.value = CardValue.jack;
        break;
      case 4:
        myCard.suit = Suit.hearts;
        myCard.value = CardValue.queen;
        break;
      case 5:
        myCard.suit = Suit.hearts;
        myCard.value = CardValue.king;
        break;
      case 6:
        myCard.suit = Suit.spades;
        myCard.value = CardValue.jack;
        break;
      case 7:
        myCard.suit = Suit.spades;
        myCard.value = CardValue.queen;
        break;
      case 8:
        myCard.suit = Suit.spades;
        myCard.value = CardValue.king;
        break;
      case 9:
        myCard.suit = Suit.diamonds;
        myCard.value = CardValue.jack;
        break;
      case 10:
        myCard.suit = Suit.diamonds;
        myCard.value = CardValue.queen;
        break;
      case 11:
        myCard.suit = Suit.diamonds;
        myCard.value = CardValue.king;
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
                child: CustomPlayingCard(myCard.suit, myCard.value, true),
              )
            : GridView.count(
                crossAxisCount: 3,
                childAspectRatio: size.width / (size.height / 1.4),
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    12,
                    (index) => GestureDetector(
                          onTapDown: (details) {
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
