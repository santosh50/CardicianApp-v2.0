import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import 'package:cardician_app_v2/card_class.dart';

class CardPredictor extends StatefulWidget {
  const CardPredictor({super.key});

  @override
  State<CardPredictor> createState() => _CardPredictorState();
}

class _CardPredictorState extends State<CardPredictor> {
  late List<MagicCard> cardList; // List of 4 input cards
  bool isTitleShown = true; // Title toggle

  @override
  void initState() {
    super.initState();

    // Initialize list with 4 empty cards
    cardList = [];
    for (int i = 0; i < 4; i++) {
      cardList.add(MagicCard());
    }
  }

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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            setState(() {
              isTitleShown = !isTitleShown;
            });
          },
          child: isTitleShown
              ? const Text(
                  'Predict Hidden Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                )
              : const Text(
                  'Fitch Cheney\'s 5 card trick',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reset cards to initial state
              setState(() {
                cardList = [];
                for (int i = 0; i < 4; i++) {
                  cardList.add(MagicCard());
                }
              });
            },
            tooltip: 'Reset Cards',
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 40,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                4,
                (id) => GestureDetector(
                    onTap: () {
                      enterCard(cardList[id]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: PlayingCardView(
                        card:
                            PlayingCard(cardList[id].suit, cardList[id].value),
                        showBack: cardList[id].showBack,
                        elevation: 10,
                      ),
                    )),
              )),
          const Divider(),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 50,
                  ))),
              onPressed: () {
                // Check if all cards are inputted
                if (cardList.any((c) => c.suit == Suit.joker)) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Enter all the cards',
                      style: TextStyle(fontSize: 18),
                    ),
                  ));
                } else {
                  // Go to prediction reveal page if all cards are entered
                  Navigator.pushNamed(context, '/prediction',
                      arguments: cardList);
                }
              },
              child: const Text(
                'Predict',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
        ],
      ),
    );
  }
}
