import 'package:cardician_app_v2/card_class.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class DisplayCard extends StatefulWidget {
  final int stage;
  final MagicCard card;

  const DisplayCard(this.stage, this.card, {super.key});

  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  final bool _showback = false;

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
      case 0:
        W = Center(
            child: SizedBox(
          width: 325,
          height: 500,
          child: PlayingCardView(
            card: PlayingCard(widget.card.suit, widget.card.value),
            showBack: _showback,
          ),
        ));
        print('OK');
    }

    return W;
  }
}
