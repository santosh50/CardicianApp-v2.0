import 'package:cardician_app_v2/pages/card_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cardician_app_v2/pages/homepage.dart';
import 'package:cardician_app_v2/pages/card_predictor.dart';
import 'package:cardician_app_v2/pages/prediction_page.dart';
import 'package:cardician_app_v2/pages/card_revealer.dart';
import 'package:cardician_app_v2/pages/card_swapper.dart';

void main() {
  //Ensure app is initialized before locking device orientation
  WidgetsFlutterBinding.ensureInitialized(); //returns Future object

  //Lock orientation to portrait and run the app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MaterialApp(
            title: 'Cardician',
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/predict': (context) => const CardPredictor(),
              '/prediction': (context) => const Prediction(),
              '/reveal': (context) => const CardRevealer(),
              '/swap': (context) => const CardSwapper(),
              '/generate': (context) => const CardGenerator(),
            },
          )));
}
