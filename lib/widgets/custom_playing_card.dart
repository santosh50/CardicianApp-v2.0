import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class CustomPlayingCard extends StatelessWidget {
  final Suit suit;
  final CardValue value;
  final bool showBack;
  const CustomPlayingCard(this.suit, this.value, this.showBack, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      height: 500,
      child: PlayingCardView(
        card: PlayingCard(suit, value),
        showBack: showBack,
      ),
    );
  }
}
