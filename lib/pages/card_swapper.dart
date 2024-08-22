import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:shake/shake.dart';

import 'package:cardician_app_v2/card_class.dart';
import 'dart:math';

class CardSwapper extends StatefulWidget {
  const CardSwapper({super.key});

  @override
  State<CardSwapper> createState() => _CardSwapperState();
}

class _CardSwapperState extends State<CardSwapper> {
  final card1 = MagicCard();
  final card2 = MagicCard();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
