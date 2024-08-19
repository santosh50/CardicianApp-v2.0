import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cardician_app_v2/pages/homepage.dart';

void main() {
  //Ensure app is initialized before locking device orientation
  WidgetsFlutterBinding.ensureInitialized(); //returns Future object

  //Fix orientation to portrait and run the app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MaterialApp(
            title: 'Cardician',
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
            },
          )));
}
