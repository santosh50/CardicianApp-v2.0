import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import 'package:cardician_app_v2/card_class.dart';

class CardPredictor extends StatefulWidget {
  const CardPredictor({super.key});

  @override
  State<CardPredictor> createState() => _CardPredictorState();
}

class _CardPredictorState extends State<CardPredictor> {
  late List<MyCard> cards;

  @override
  void initState() {
    super.initState();

    cards = [];
    for (int i = 0; i < 4; i++) {
      cards.add(MyCard());
    }
  }

  void selectCard(int id) {
    CardValue selectedValue = CardValue.joker_1;
    Suit selectedSuit = Suit.joker;

    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    13,
                    (index) => TextButton(
                          onPressed: () {
                            selectedValue = valList[index];
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: GridView.count(
                                    crossAxisCount: 2,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                      4,
                                      (index) => IconButton(
                                        onPressed: () {
                                          selectedSuit = suitList[index];
                                          Navigator.of(context).pop();
                                          setState(() {
                                            cards[id].value = selectedValue;
                                            cards[id].suit = selectedSuit;
                                            cards[id].showBack = false;
                                          });
                                        },
                                        icon: Image.asset(
                                            'images/${suitMap[suitList[index]]}.png'),
                                      ),
                                    )),
                              ),
                            );
                          },
                          child: Text(
                            '${valueMap[valList[index]]}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontFamily: 'Georgia'),
                          ),
                        )),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          '5th Card Prediction',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                cards = [];
                for (int i = 0; i < 4; i++) {
                  cards.add(MyCard());
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
                    // selectCard(id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: PlayingCardView(
                      card: PlayingCard(cards[id].suit, cards[id].value),
                      showBack: cards[id].showBack,
                      elevation: 10,
                    ),
                  ),
                ),
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
                if (cards.any((c) => c.suit == Suit.joker)) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Enter all the cards',
                      style: TextStyle(fontSize: 18),
                    ),
                  ));
                } else {
                  Navigator.pushNamed(context, '/prediction', arguments: cards);
                }
              },
              child: const Text(
                'Predict',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
