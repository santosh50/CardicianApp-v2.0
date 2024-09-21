import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

// Custom playing card widget with fixed dimensions
class CustomPlayingCard extends StatelessWidget {
  final Suit suit;
  final CardValue value;
  final bool showBack;
  const CustomPlayingCard(this.suit, this.value, this.showBack, {super.key});

  @override
  Widget build(BuildContext context) {
    // Render Playing Card widget with fixed height and width
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
