import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import 'package:cardician_app_v2/card_class.dart';

class CardRevealer extends StatefulWidget {
  const CardRevealer({super.key});

  @override
  State<CardRevealer> createState() => _CardRevealerState();
}

class _CardRevealerState extends State<CardRevealer> {
  late MyCard card;
  bool isCardSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isCardSelected
          ? Center(
              child: PlayingCardView(card: PlayingCard(card.suit, card.value)),
            )
          : Container(),
    );
  }
}
