import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class DisplayCard extends StatefulWidget {
  final int _stage;

  const DisplayCard(this._stage, {super.key});

  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  Suit displaySuit = Suit.joker;
  CardValue displayValue = CardValue.joker_1;
  final bool _showback = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 325,
      height: 500,
      child: PlayingCardView(
        card: PlayingCard(displaySuit, displayValue),
        showBack: _showback,
      ),
    ));
  }
}
