import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:cardician_app_v2/widgets/custom_playing_card.dart';

import 'package:cardician_app_v2/card_class.dart';

class CardPredictor extends StatefulWidget {
  const CardPredictor({super.key});

  @override
  State<CardPredictor> createState() => _CardPredictorState();
}

class _CardPredictorState extends State<CardPredictor> {
  late List<MagicCard> cardList;

  @override
  void initState() {
    super.initState();

    cardList = [];
    for (int i = 0; i < 4; i++) {
      cardList.add(MagicCard());
    }
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
        title: const Text(
          'Predict Hidden Card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
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
                (id) => InkWell(
                    onTap: () {
                      enterCard(cardList[id]);
                    },
                    child: CustomPlayingCard(cardList[id].suit,
                        cardList[id].value, cardList[id].showBack)),
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
                if (cardList.any((c) => c.suit == Suit.joker)) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Enter all the cards',
                      style: TextStyle(fontSize: 18),
                    ),
                  ));
                } else {
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
