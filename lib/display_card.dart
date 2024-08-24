import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import 'package:cardician_app_v2/card_class.dart';
import "dart:math";

class DisplayCard extends StatefulWidget {
  final int stage;
  final MagicCard card;

  const DisplayCard(this.stage, this.card, {super.key});

  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  bool _showback = true;
  final MagicCard _displayCard = MagicCard();

  void generateRandomCard() {
    setState(() {
      _displayCard.suit = suitList[Random().nextInt(4)];
      _displayCard.value = valList[Random().nextInt(13)];
      _showback = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget W = const Center(
      //Default error widget
      child: Text(
        'Display Card Error',
        style: TextStyle(color: Colors.red, fontSize: 35),
      ),
    );

    switch (widget.stage) {
      case 1:
        W = Center(
            child: GestureDetector(
          onTap: () {
            generateRandomCard();
          },
          onLongPress: () {
            setState(() {
              _displayCard.suit = widget.card.suit;
              _displayCard.value = widget.card.value;
              _showback = false;
            });
          },
          child: SizedBox(
            width: 325,
            height: 500,
            child: PlayingCardView(
              card: PlayingCard(_displayCard.suit, _displayCard.value),
              showBack: _showback,
            ),
          ),
        ));
    }

    return W;
  }
}
