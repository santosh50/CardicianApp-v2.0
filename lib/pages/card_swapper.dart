import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import 'package:cardician_app_v2/card_class.dart';

class DisplayCard extends StatefulWidget {
  final int _stage;

  const DisplayCard(this._stage, {super.key});

  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  Suit displaySuit = Suit.joker;
  CardValue displayValue = CardValue.joker_1;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
    ));
  }
}

class CardSwapper extends StatefulWidget {
  const CardSwapper({super.key});

  @override
  State<CardSwapper> createState() => _CardSwapperState();
}

class _CardSwapperState extends State<CardSwapper> {
  final card1 = MagicCard();
  final card2 = MagicCard();
  int stage = 0;

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
                                    if (card1.suit != Suit.joker &&
                                        card2.suit != Suit.joker) {
                                      stage++;
                                    }
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

  Widget getStageWidget() {
    Widget widget = Container(
      color: Colors.yellow,
    );

    switch (stage) {
      case 0:
        widget = GestureDetector(
          onLongPress: () {
            enterCard(card1);
            enterCard(card2);
          },
          child: Container(
            color: Colors.black,
          ),
        );
        break;
      case 1:
        widget = Container(
          color: Colors.pink,
        );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getStageWidget(),
    );
  }
}
