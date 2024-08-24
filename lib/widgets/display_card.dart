import 'package:flutter/material.dart';

import 'package:cardician_app_v2/card_class.dart';
import 'package:cardician_app_v2/widgets/custom_playing_card.dart';
import "dart:math";

class DisplayCard extends StatefulWidget {
  final int stage;
  final MagicCard card;

  const DisplayCard(this.stage, this.card, {super.key});

  @override
  State<DisplayCard> createState() => _MyCardState();
}

class _MyCardState extends State<DisplayCard> {
  final MagicCard _myCard = MagicCard();

  late int _currentStage;
  double _top = 155;

  @override
  void initState() {
    super.initState();

    _currentStage = widget.stage;
  }

  void generateRandomCard() {
    setState(() {
      _myCard.suit = suitList[Random().nextInt(4)];
      _myCard.value = valList[Random().nextInt(13)];
      _myCard.showBack = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget W = const Center(
      //Default error widget
      child: Text(
        'Display Card Error',
        style: TextStyle(color: Colors.red, fontSize: 35),
      ),
    );

    switch (_currentStage) {
      case 1:
        W = Center(
            child: GestureDetector(
          onTap: () {
            generateRandomCard();
          },
          onLongPress: () {
            setState(() {
              _myCard.suit = widget.card.suit;
              _myCard.value = widget.card.value;
              _myCard.showBack = false;
              _currentStage = 2;
            });
          },
          child:
              CustomPlayingCard(_myCard.suit, _myCard.value, _myCard.showBack),
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
                  _currentStage = 3;
                });
              },
              child: GestureDetector(
                onTap: () {
                  generateRandomCard();
                  setState(() {
                    _currentStage = 1;
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
                child: CustomPlayingCard(
                    _myCard.suit, _myCard.value, _myCard.showBack),
              ),
            ),
          ]),
        );
    }

    return W;
  }
}
