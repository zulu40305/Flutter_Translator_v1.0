import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/game/FlashCardList.dart';

import 'package:translator_testing/view/translator_text.dart';
import 'package:translator_testing/view/translator_image.dart';
import 'package:translator_testing/view/translator_conversation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<AppState>(
      builder: (context, appState, _) => MaterialApp(
        title: appState.appTitle,
        initialRoute: '/text',
        routes: {
          '/text': (BuildContext context) => const TranslatorText(),
          '/image': (BuildContext context) => Consumer<AppState>(builder: (context, appState, _) => TranslatorImage(cameras: appState.cameras)),
          '/conversation': (BuildContext context) => const TranslatorConversation(),
          '/learning': (BuildContext context) => const FlashCardList(),
        }
      )
    );
  }
}