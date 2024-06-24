import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/app.dart';
import 'package:translator_testing/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Translator-Echo',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_) {
    runApp(ChangeNotifierProvider(
      create: (context) => AppState(),
      builder: ((context, child) => const App()),
    ));
  });
}

