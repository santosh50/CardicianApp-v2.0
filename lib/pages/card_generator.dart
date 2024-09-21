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
  final card1 = MagicCard(); // First revealed card
  final card2 = MagicCard(); // Second revealed card
  final _displayCard = MagicCard(); // Card rendered in UI

  int _stage = 0; // Represents card trick state

  // Input the suit and value of the card
  void enterCard(MagicCard card) {
    CardValue value = CardValue.joker_1;
    Suit suit = Suit.joker;

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

  // Cycle through random cards recursively
  void cycleRandomCards() {
    if (_stage % 2 == 0) return; // Exit case for even stages (Display card)

    setState(() {
      _displayCard.generateRandomCard();
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      cycleRandomCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Top card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Go to next stage for even stages
              if (_stage == 2) {
                setState(() {
                  _displayCard.showBack = true;
                  _stage++; // Go to stage 3
                });
              } else if (_stage == 4) {
                setState(() {
                  _displayCard.showBack = true;
                  _stage++; // Go to stage 5
                });
              }
            },
            tooltip: 'Reset Card',
          ),
        ],
      ),
      body: (_stage == 0) //Initial stage check
          ? GestureDetector(
              onLongPress: () {
                // Input the 2 cards
                enterCard(card1);
                enterCard(card2);
              },
              child: Container(
                color: Colors.grey[300],
              ),
            )
          : Center(
              child: GestureDetector(
                onTap: () {
                  if (_displayCard.showBack) {
                    // Generate random cards for odd stages
                    cycleRandomCards();
                  } else {
                    switch (_stage) {
                      case 1:
                        setState(() {
                          _displayCard.inputCard(card1.value, card1.suit);
                          _stage++; // Go to stage 2
                        });
                        break;
                      case 3:
                        setState(() {
                          _displayCard.inputCard(card2.value, card2.suit);
                          _stage++; // Go to stage 4
                        });
                        break;
                      case 5:
                        setState(() {
                          _stage--; // Go to stage 4
                        });
                    }
                  }
                },
                child: CustomPlayingCard(_displayCard.suit, _displayCard.value,
                    _displayCard.showBack),
              ),
            ),
    );
  }
}
