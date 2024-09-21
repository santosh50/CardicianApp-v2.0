import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import 'package:cardician_app_v2/card_class.dart';
import 'package:cardician_app_v2/custom_playing_card.dart';

class CardGenerator extends StatefulWidget {
  const CardGenerator({super.key});

  @override
  State<CardGenerator> createState() => _CardGeneratorState();
}

class _CardGeneratorState extends State<CardGenerator> {
  final card1 = MagicCard(); //first revealed card
  final card2 = MagicCard(); //second revealed card
  final _displayCard = MagicCard(); //card rendered in UI

  final int _stage = 0; //represents card trick state

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
