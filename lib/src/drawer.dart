import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/controller/show_alert.dart';
import 'package:translator_testing/game/FlashCardList.dart';
import 'package:translator_testing/model/translator_data.dart';
import 'package:translator_testing/src/sign_button.dart';
import 'package:translator_testing/view/translator_conversation.dart';
import 'package:translator_testing/view/translator_image.dart';
import 'package:translator_testing/view/translator_text.dart';

class DrawerLayout extends StatelessWidget {
  const DrawerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListView(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 65, 105, 225),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200.0),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 65, 105, 225)
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200.0),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: appState.loggedIn
                                ? Image.network(FirebaseAuth.instance.currentUser!.photoURL.toString())
                                : Image.asset('assets/images/unknown_user.png'),
                              )
                            )
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            appState.loggedIn
                            ? 'Welcome, ${FirebaseAuth.instance.currentUser!.displayName}!'
                            : 'Sign in to use more functions!',
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      const SignButton()
                    ]
                  )
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(
                        Icons.text_format_outlined,
                        color: Color.fromARGB(255, 65, 105, 225)
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        '텍스트 번역기',
                        style: TextStyle(color: Color.fromARGB(255, 65, 105, 225))
                      ),
                    ],
                  ),
                  onTap: () {
                    if (appState.translator.value != 'text') {
                      appState.selectTranslator(NavigatorValue(name: '텍스트 번역', value: 'text'));
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const TranslatorText()),
                        (route) => false
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Color.fromARGB(255, 65, 105, 225)
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        '이미지 번역기',
                        style: TextStyle(color: Color.fromARGB(255, 65, 105, 225))
                      ),
                    ],
                  ),
                  onTap: () {
                    if (appState.translator.value != 'image') {
                      appState.selectTranslator(NavigatorValue(name: '이미지 번역', value: 'image'));
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => TranslatorImage(cameras: appState.cameras)),
                        (route) => false
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(
                        Icons.chat_outlined,
                        color: Color.fromARGB(255, 65, 105, 225)
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        '대화 번역기',
                        style: TextStyle(color: Color.fromARGB(255, 65, 105, 225))
                      ),
                    ],
                  ),
                  onTap: () {
                    if (appState.translator.value != 'conversation') {
                      appState.selectTranslator(NavigatorValue(name: '대화 번역', value: 'conversation'));
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const TranslatorConversation()),
                        (route) => false
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTile(
                  title: const Row(
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: Color.fromARGB(255, 65, 105, 225)
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        '단어 학습',
                        style: TextStyle(color: Color.fromARGB(255, 65, 105, 225))
                      ),
                    ],
                  ),
                  onTap: () {
                    if (appState.loggedIn) {
                      if (appState.translator.value != 'learning') {
                        appState.selectTranslator(NavigatorValue(name: '단어 학습', value: 'learning'));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const FlashCardList()),
                          (route) => false
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    } else {
                      showAlertDialog(context, '해당 기능은 로그인 후에 사용할 수 있습니다!');
                    }
                  },
                )
              ]
            ),
          )
        )
      )
    );
  }
}