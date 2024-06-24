import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/controller/show_alert.dart';
import 'package:translator_testing/model/language_data.dart';
import 'package:translator_testing/src/drawer.dart';
import 'package:translator_testing/src/icon_button_widget.dart';
import 'package:translator_testing/src/language_selector.dart';
import 'package:translator_testing/src/translator_selector.dart';

class TranslatorConversation extends StatefulWidget {
  const TranslatorConversation({super.key});

  @override
  State<TranslatorConversation> createState() => _TranslatorConversationState();
}

class _TranslatorConversationState extends State<TranslatorConversation> with TickerProviderStateMixin {
  bool speakerListening_1 = false;
  bool speakerListening_2 = false;
  String speakerTarget = '';

  final SpeechToText stt = SpeechToText();
  String _wordsSpoken = '';
  String _translatedWordsTemp = '';
  String _translatedWords = '';

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    await stt.initialize(onStatus: _onSpeechStatus);
    setState(() {});
  }

  void _startListening(TranslatorValue source, TranslatorValue target) async {
    setState(() {
      _wordsSpoken = '';
      _translatedWords = '';
    });

    await stt.listen(onResult: (result) async {
      AppState appState = Provider.of<AppState>(context, listen: false);
      _translatedWordsTemp = await appState.useConversationTranslator(source, target, result.recognizedWords);
      setState(() {
        _wordsSpoken = result.recognizedWords;
        _translatedWords = _translatedWordsTemp;
      });
    }, 
      localeId: source.iso_language_code,
    );
  }

  void _stopListening() async {
    await stt.stop();
    setState(() {});
  }

  void _onSpeechStatus(String status) {
    if (status == 'done' || status == 'notListening') {
      setState(() {
        speakerListening_1 = false;
        speakerListening_2 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Scaffold(
        drawer: const DrawerLayout(),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const LanguageSelector(),
                const SizedBox(height: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration( 
                        color: const Color.fromARGB(255, 238, 241, 248),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              '${appState.sourceLanguage.name} / ${appState.sourceLanguage.native_name}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 65, 105, 225),
                                fontSize: 12
                              )
                            ),
                          ),
                          Text(
                            speakerTarget == 'Speaker_1' ? _wordsSpoken : _translatedWords,
                            style: const TextStyle(fontSize: 20)
                          )
                        ],
                      )
                    )
                  )
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration( 
                        color: const Color.fromARGB(255, 238, 241, 248),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              '${appState.targetLanguage.name} / ${appState.targetLanguage.native_name}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 65, 105, 225),
                                fontSize: 12
                              )
                            ),
                          ),
                          Text(
                            speakerTarget == 'Speaker_2' ? _wordsSpoken : _translatedWords,
                            style: const TextStyle(fontSize: 20)
                          )
                        ],
                      )
                    )
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButtonWidget(
                          borderColor: const Color.fromARGB(255, 65, 105, 225),
                          backgroundColor: const Color.fromARGB(255, 65, 105, 225),
                          iconColor: Colors.white,
                          buttonIcon: speakerListening_1
                          ? Icons.crop_square_outlined
                          : Icons.mic,
                          iconSize: 25.0,
                          padding: 17.0,
                          function: () {
                            if (appState.sourceLanguage.iso_language_code != null) {
                              if (speakerListening_1) {
                                _stopListening();
                                setState(() {
                                  speakerListening_1 = false;
                                });
                              } else {
                                _stopListening();
                                setState(() {
                                  speakerTarget = 'Speaker_1';
                                  speakerListening_1 = true;
                                  speakerListening_2 = false;
                                });
                                _startListening(
                                  appState.sourceLanguage,
                                  appState.targetLanguage,
                                );
                              }
                            } else {
                              showAlertDialog(
                                context,
                                '해당 언어는 아직 대화 번역 기능을 지원하지 않습니다.',
                              );
                            }
                          }
                        ),
                        Container(
                          width: 150.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration( 
                            border: Border.all(color: const Color.fromARGB(255, 65, 105, 225), width: 1.5),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            '${appState.sourceLanguage.name} / ${appState.sourceLanguage.native_name}',
                            overflow: TextOverflow.ellipsis,
                          )
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButtonWidget(
                          borderColor: const Color.fromARGB(255, 65, 105, 225),
                          backgroundColor: const Color.fromARGB(255, 65, 105, 225),
                          iconColor: Colors.white,
                          buttonIcon: speakerListening_2 
                          ? Icons.crop_square_outlined
                          : Icons.mic,
                          iconSize: 25.0,
                          padding: 17.0,
                          function: () {
                            if (appState.targetLanguage.iso_language_code != null) {
                              if (speakerListening_2) {
                                _stopListening();
                                setState(() {
                                  speakerListening_2 = false;
                                });
                              } else {
                                _stopListening();
                                setState(() {
                                  speakerTarget = 'Speaker_2';
                                  speakerListening_1 = false;
                                  speakerListening_2 = true;
                                });
                                _startListening(
                                  appState.targetLanguage,
                                  appState.sourceLanguage,
                                );
                              }
                            } else {
                              showAlertDialog(
                                context,
                                '해당 언어는 아직 대화 번역 기능을 지원하지 않습니다.',
                              );
                            }
                          }
                        ),
                        Container(
                          width: 150.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration( 
                            border: Border.all(color: const Color.fromARGB(255, 65, 105, 225), width: 1.5),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            '${appState.targetLanguage.name} / ${appState.targetLanguage.native_name}',
                            overflow: TextOverflow.ellipsis,
                          )
                        )
                      ],
                    ),
                  ]
                ),
                Builder(
                  builder: (context) {
                    return TranslatorSelector(
                      function: () { Scaffold.of(context).openDrawer(); }
                    );
                  },
                )
              ],
            )
          ),
        ),
      )
    );
  }
}