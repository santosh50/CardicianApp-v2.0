import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:shake/shake.dart';

import 'package:cardician_app_v2/card_class.dart';

class CardSwapper extends StatefulWidget {
  const CardSwapper({super.key});

  @override
  State<CardSwapper> createState() => _CardSwapperState();
}

class _CardSwapperState extends State<CardSwapper> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
