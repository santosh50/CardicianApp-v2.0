import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import 'package:cardician_app_v2/card_class.dart';

class CardSwapper extends StatefulWidget {
  const CardSwapper({super.key});

  @override
  State<CardSwapper> createState() => _CardSwapperState();
}

class _CardSwapperState extends State<CardSwapper> {
  final card1 = MagicCard();
  final card2 = MagicCard();

  void enterCard(MagicCard card) {
    CardValue inputValue = CardValue.joker_1;
    Suit inputSuit = Suit.joker;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              13,
              (index) => TextButton(
                    child: Text(
                      '${valueMap[valList[index]]}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontFamily: 'Georgia'),
                    ),
                    onPressed: () {
                      inputValue = valList[index];
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              4,
                              (index) => IconButton(
                                icon: Image.asset(
                                    'images/${suitMap[suitList[index]]}.png'),
                                onPressed: () {
                                  inputSuit = suitList[index];
                                  Navigator.of(context).pop();
                                  setState(() {
                                    card.value = inputValue;
                                    card.suit = inputSuit;
                                    card.showBack = false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          enterCard(card2);
          enterCard(card1);
        },
        child: Center(
          child: PlayingCardView(card: PlayingCard(card2.suit, card2.value)),
        ),
      ),
    );
  }
}
