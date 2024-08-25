import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import 'package:cardician_app_v2/card_class.dart';
import 'package:cardician_app_v2/custom_playing_card.dart';
// import 'package:cardician_app_v2/widgets/display_card.dart';
import "dart:math";

class CardSwapper extends StatefulWidget {
  const CardSwapper({super.key});

  @override
  State<CardSwapper> createState() => _CardSwapperState();
}

class _CardSwapperState extends State<CardSwapper> {
  final card1 = MagicCard();
  final card2 = MagicCard();
  final _displayCard = MagicCard();

  int _stage = 0;
  double _top = 155;

  void generateRandomCard() {
    setState(() {
      _displayCard.suit = suitList[Random().nextInt(4)];
      _displayCard.value = valList[Random().nextInt(13)];
      _displayCard.showBack = false;
    });
  }

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
                                      _stage = 1;
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
    Widget W = const Center(
      //Default error message
      child: Text(
        'Card Swapper Error',
        style: TextStyle(color: Colors.red, fontSize: 35),
      ),
    );

    switch (_stage) {
      case 0:
        W = GestureDetector(
          onLongPress: () {
            enterCard(card2);
            enterCard(card1);
          },
          child: Container(
            color: Colors.black,
          ),
        );
        break;
      case 1:
        W = Center(
            child: GestureDetector(
          onTap: () {
            generateRandomCard();
          },
          onLongPress: () {
            setState(() {
              _displayCard.suit = card1.suit;
              _displayCard.value = card1.value;
              _displayCard.showBack = false;
              _stage = 2;
            });
          },
          child: CustomPlayingCard(
              _displayCard.suit, _displayCard.value, _displayCard.showBack),
        ));
        break;
      case 2:
        W = Center(
          child: Stack(children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              top: _top,
              left: 30,
              onEnd: () {
                setState(() {
                  _stage = 3;
                });
              },
              child: GestureDetector(
                onTap: () {
                  generateRandomCard();
                  setState(() {
                    _stage = 1;
                  });
                },
                onVerticalDragUpdate: (dragDetails) {
                  int sensitivity = -10;
                  if (dragDetails.primaryDelta! < sensitivity) {
                    setState(() {
                      _top = -500;
                    });
                  }
                },
                child: CustomPlayingCard(_displayCard.suit, _displayCard.value,
                    _displayCard.showBack),
              ),
            ),
          ]),
        );
    }

    return W;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getStageWidget(),
    );
  }
}
