import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/controller/show_alert.dart';
import 'package:translator_testing/game/FlashCardField.dart';
import 'package:translator_testing/game/FlashCardList.dart';
import 'package:translator_testing/src/rounded_button.dart';

class FlashCardForm extends StatefulWidget {
  const FlashCardForm({required this.flashcard_ID, super.key});

  final String flashcard_ID;

  @override
  State<FlashCardForm> createState() => _FlashCardFormState();
}

class _FlashCardFormState extends State<FlashCardForm> {
  final _formKey = GlobalKey<FormState>();

  final _controller_word = TextEditingController();
  final _controller_meaning = TextEditingController();
  final _controller_synonym = TextEditingController();
  final _controller_antonym = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 105, 225)),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const Text(
                        '플래시카드 추가',
                        style: TextStyle(
                          fontSize: 18.0
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      FlashCardField(
                        fieldController: _controller_word,
                        fieldName: '단어 / Word',
                      ),
                      const SizedBox(height: 15.0),
                      FlashCardField(
                        fieldController: _controller_meaning,
                        fieldName: '의미 / Meaning',
                      ),
                      const SizedBox(height: 15.0),
                      FlashCardField(
                        fieldController: _controller_synonym,
                        fieldName: '동의어 / Synonym',
                      ),
                      const SizedBox(height: 15.0),
                      FlashCardField(
                        fieldController: _controller_antonym,
                        fieldName: '반의어 / Antonym',
                      ),
                      const SizedBox(height: 30.0),
                      RoundedButton(
                        content: '저장하기',
                        function: () async {
                          if (
                            _controller_word.text.replaceAll(RegExp(r'\s+'), '') != '' 
                            && _controller_meaning.text.replaceAll(RegExp(r'\s+'), '') != '' 
                          ) {
                            await appState.addFlashCard(
                              widget.flashcard_ID,
                              _controller_word.text,
                              _controller_meaning.text,
                              _controller_synonym.text,
                              _controller_antonym.text
                            );
                            _controller_word.text = '';
                            _controller_meaning.text = '';
                            _controller_synonym.text = '';
                            _controller_antonym.text = '';
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar( 
                                const SnackBar(
                                  content: Text('플래시카드가 추가되었습니다!'),
                                  duration: Duration(milliseconds: 1500),
                                )
                              );
                            }
                          } else {
                            showAlertDialog(context, '단어와 의미를 모두 입력해주세요');
                          }
                        },
                        textColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 65, 105, 225),
                        fontSize: 14.0,
                        width: 100.0,
                      )
                    ],
                  )
                )
              )
            )
          )
          )
        )
      )
    );
  }
}