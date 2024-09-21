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
  final _displayCard = MagicCard(); // Card rendered in UI
  bool isCardSelected = false;

  // Select card based on screen position tapped
  void selectCard(int index) {
    switch (index) {
      case 0:
        _displayCard.inputCard(CardValue.jack, Suit.clubs);
        break;
      case 1:
        _displayCard.inputCard(CardValue.queen, Suit.clubs);
        break;
      case 2:
        _displayCard.inputCard(CardValue.king, Suit.clubs);
        break;
      case 3:
        _displayCard.inputCard(CardValue.jack, Suit.hearts);
        break;
      case 4:
        _displayCard.inputCard(CardValue.queen, Suit.hearts);
        break;
      case 5:
        _displayCard.inputCard(CardValue.king, Suit.hearts);
        break;
      case 6:
        _displayCard.inputCard(CardValue.jack, Suit.spades);
        break;
      case 7:
        _displayCard.inputCard(CardValue.queen, Suit.spades);
        break;
      case 8:
        _displayCard.inputCard(CardValue.king, Suit.spades);
        break;
      case 9:
        _displayCard.inputCard(CardValue.jack, Suit.diamonds);
        break;
      case 10:
        _displayCard.inputCard(CardValue.queen, Suit.diamonds);
        break;
      case 11:
        _displayCard.inputCard(CardValue.king, Suit.diamonds);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // Fetch entire screen size

    return Scaffold(
      backgroundColor: Colors.black,
      body: Scratcher(
        brushSize: 100,
        onScratchUpdate: () => setState(() {
          // Reveal the selected card
          isCardSelected = true;
        }),
        child: isCardSelected
            ? Center(
                child: CustomPlayingCard(
                    _displayCard.suit, _displayCard.value, false),
              )
            : GridView.count(
                crossAxisCount: 3,
                childAspectRatio: size.width /
                    (size.height / 1.4), // Size of container to be tapped
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
