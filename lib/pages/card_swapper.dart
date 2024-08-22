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

  bool isSuitSelected = false;

  // void inputCard(MagicCard card) {
  //   Suit inputSuit;
  //   CardValue inputValue;

  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return isSuitSelected ? Container() : Container();
  //     },
  //   );
  //   // builder:  (context) => Dialog(
  //   //   child: GridView.count(
  //   //     crossAxisCount: 4,
  //   //     shrinkWrap: true,
  //   //     physics: const NeverScrollableScrollPhysics(),
  //   //     children: List.generate(
  //   //         13,
  //   //         (index) => TextButton(
  //   //               child: Text(
  //   //                 '${valueMap[valList[index]]}',
  //   //                 style: const TextStyle(
  //   //                     color: Colors.black,
  //   //                     fontSize: 36,
  //   //                     fontFamily: 'Georgia'),
  //   //               ),
  //   //               onPressed: () {
  //   //                 inputValue = valList[index];
  //   //                 // Navigator.of(context).pop();
  //   //               },
  //   //             )),
  //   //   ),
  //   // ),

  // showDialog(
  //   context: context,
  //   builder: (context) => Dialog(
  //     child: GridView.count(
  //       crossAxisCount: 2,
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       children: List.generate(
  //         4,
  //         (index) => IconButton(
  //             onPressed: () {
  //               inputSuit = suitList[index];
  //             },
  //             icon: Image.asset('images/${suitMap[suitList[index]]}.png')),
  //       ),
  //     ),
  //   ),
  // );
  // }

  @override
  Widget build(BuildContext context) {
    card1.suit = Suit.hearts;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          // inputValue(context);
          inputSuit(context);
        },
        child: Center(
          child: PlayingCardView(card: PlayingCard(card1.suit, card1.value)),
        ),
      ),
    );
  }
}
