import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';
import 'package:flip_card/flip_card.dart';

import 'package:cardician_app_v2/card_class.dart';

class Prediction extends StatefulWidget {
  const Prediction({super.key});

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  List _cards = [];

  int compareCards(a, b) {
    if (valList.indexOf(a.value) < valList.indexOf(b.value)) {
      return -1;
    } else if (valList.indexOf(a.value) > valList.indexOf(b.value)) {
      return 1;
    } else {
      if (suitList.indexOf(a.suit) < suitList.indexOf(b.suit)) {
        return -1;
      } else if (suitList.indexOf(a.suit) > suitList.indexOf(b.suit)) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  PlayingCard predictHiddenCard(List cards) {
    //Determine order
    final List triplet = cards.sublist(1);
    List tripletSorted = List.from(triplet);
    tripletSorted.sort(compareCards);
    final order = triplet.map((e) => tripletSorted.indexOf(e)).toList();

    //Determine additional count
    int addCount = order[0] * 4 + order[1] * 2 + order[2];
    int temp = addCount - 3;
    addCount = temp - (temp ~/ 4);

    //Determine Hidden Card
    final MagicCard keyCard = cards[0];
    final Suit hiddenSuit = keyCard.suit;
    int position = valList.indexOf(keyCard.value);
    position = (position + addCount) % 13;
    final hiddenValue = valList[position];

    return PlayingCard(hiddenSuit, hiddenValue);
  }

  @override
  Widget build(BuildContext context) {
    _cards = ModalRoute.of(context)?.settings.arguments as List;
    PlayingCard hiddenCard = predictHiddenCard(_cards);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: FlipCard(
          front: PlayingCardView(
            card: hiddenCard,
            showBack: true,
          ),
          back: PlayingCardView(
            card: hiddenCard,
            showBack: false,
          ),
        ),
      )),
    );
  }
}
