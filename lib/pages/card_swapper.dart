import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:shake_detector/shake_detector.dart';

import 'package:cardician_app_v2/card_class.dart';
import 'package:cardician_app_v2/custom_playing_card.dart';

class CardSwapper extends StatefulWidget {
  const CardSwapper({super.key});

  @override
  State<CardSwapper> createState() => _CardSwapperState();
}

class _CardSwapperState extends State<CardSwapper> {
  final card1 = MagicCard(); // Swapped card
  final card2 = MagicCard(); // Initial card
  final _displayCard = MagicCard(); // Card rendered in UI

  int _stage = 0; // Represents card trick state
  double _top = 155; // For slide animation
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    // Initialize shake detector
    detector = ShakeDetector.waitForStart(onShake: () {
      setState(() {
        // Go to stage 3 on phone shake
        _stage = 3;
      });
    });
  }

  void enterCard(MagicCard card) {
    CardValue value = CardValue.joker_1; // Card inputValue
    Suit suit = Suit.joker; // Card inputSuit

    showDialog(
      // Select the value
      context: context,
      builder: (context) => Dialog(
        child: GridView.count(
          // Grid of values
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
                      value = valList[index];
                      Navigator.of(context).pop();
                      showDialog(
                        // Select the suit
                        context: context,
                        builder: (context) => Dialog(
                          child: GridView.count(
                            // Grid of suits
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              4,
                              (index) => IconButton(
                                icon: Image.asset(
                                    'images/${suitMap[suitList[index]]}.png'),
                                onPressed: () {
                                  suit = suitList[index];
                                  Navigator.of(context).pop();
                                  setState(() {
                                    card.inputCard(value, suit);
                                    // If both cards are selected, go to next stage (1)
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

  Widget renderStageWidget() {
    Widget W = const Center(
      // Default error message
      child: Text(
        'Card Swapper Error',
        style: TextStyle(color: Colors.red, fontSize: 35),
      ),
    );

    switch (_stage) {
      case 0: // Input the cards to be swapped
        W = GestureDetector(
          onLongPress: () {
            enterCard(card1);
            enterCard(card2);
          },
          child: Container(
            color: Colors.black,
          ),
        );
        break;
      case 1: // Showback and generate random cards on tap
        W = Center(
            child: GestureDetector(
          onTap: () {
            setState(() {
              _displayCard.generateRandomCard();
            });
          },
          onVerticalDragUpdate: (dragDetails) {
            if (dragDetails.primaryDelta! > 0) {
              // On swipe down, go to next stage (2)
              setState(() {
                _displayCard.inputCard(card1.value, card1.suit);
                _stage = 2;
              });
            }
          },
          child: CustomPlayingCard(
              _displayCard.suit, _displayCard.value, _displayCard.showBack),
        ));
        break;
      case 2: // Swap the cards with slide followed by shake
        W = Center(
          child: Stack(children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: _top,
              left: 30,
              onEnd: () {
                // Wait for phone shake after swipe up animation
                detector.startListening();
              },
              child: GestureDetector(
                onTap: () {
                  // On tap, go to previous stage (1)
                  setState(() {
                    _displayCard.generateRandomCard();
                    _stage = 1;
                  });
                },
                onVerticalDragUpdate: (dragDetails) {
                  // On swipe up, slide card upwards, out of the screen
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
      case 3: // Display swapped card and remove it on right drag
        detector.stopListening();
        setState(() {
          // Show swapped card
          _displayCard.inputCard(card2.value, card2.suit);
        });
        W = Center(
          child: Draggable(
            feedback: CustomPlayingCard(
                _displayCard.suit, _displayCard.value, _displayCard.showBack),
            childWhenDragging: Container(),
            onDraggableCanceled: (velocity, offset) {
              if (offset.dx > 200) {
                // Go to initial stage on right drag
                setState(() {
                  _stage = 0;
                });
              }
            },
            child: CustomPlayingCard(
                _displayCard.suit, _displayCard.value, _displayCard.showBack),
          ),
        );
    }

    return W;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: renderStageWidget(),
    );
  }
}
