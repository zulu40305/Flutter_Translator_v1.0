import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/controller/show_alert.dart';
import 'package:translator_testing/src/drawer.dart';
import 'package:translator_testing/src/language_selector.dart';
import 'package:translator_testing/src/translator_selector.dart';

class TranslatorText extends StatefulWidget {
  const TranslatorText({super.key});

  @override
  State<TranslatorText> createState() => _TranslatorTextState();
}

class _TranslatorTextState extends State<TranslatorText> {
  final TextEditingController _inputController = TextEditingController();
  String translatedText = '';
  String _targetLanguageText = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Scaffold(
        drawer: const DrawerLayout(),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const LanguageSelector(),
                Expanded(
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 238, 241, 248),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(15.0),
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: SingleChildScrollView(
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  maxLines: null,
                                  controller: _inputController,
                                  decoration: const InputDecoration(
                                    hintText: '텍스트를 입력해주세요...',
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  onChanged: (text) async {
                                    translatedText = await appState.translateText(text);
                                    setState(() {
                                      _targetLanguageText = translatedText;
                                    });
                                  },
                                  onTap: () {
                                    FocusScope.of(context).hasFocus
                                    ? FocusScope.of(context).unfocus()
                                    : FocusScope.of(context).requestFocus();
                                  }
                                ),
                                _inputController.text.replaceAll(RegExp(r'\s+'), '') != ''
                                ? Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.volume_up),
                                      onPressed: () {
                                        if (appState.sourceLanguage.iso_language_code != null) {
                                          appState.useTTS(_inputController.text, appState.sourceLanguage);
                                        } else {
                                          showAlertDialog(context, '해당 언어는 아직 읽기 기능을 지원하지 않습니다.');
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.copy),
                                      onPressed: () async {
                                        await Clipboard.setData(
                                              ClipboardData(text: _inputController.text)
                                            )
                                              .then(
                                              (_) => ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    '클립보드에 복사되었습니다.',
                                                    textAlign: TextAlign.start,
                                                  )
                                                )
                                              )
                                            );
                                      },
                                    ),
                                    Text(
                                      '${appState.sourceLanguage.name} / ${appState.sourceLanguage.native_name}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                )
                                : Container(),
                                _inputController.text.replaceAll(RegExp(r'\s+'), '') != '' 
                                ? const Divider(color: Colors.blueAccent)
                                : Container(),
                                _targetLanguageText != '' 
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text(
                                        _targetLanguageText != '' ? _targetLanguageText : '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.volume_up),
                                          onPressed: () {
                                            if (appState.targetLanguage.iso_language_code != null) {
                                              appState.useTTS(translatedText, appState.targetLanguage);
                                            } else {
                                              showAlertDialog(context, '해당 언어는 아직 읽기 기능을 지원하지 않습니다.');
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.copy),
                                          onPressed: () async {
                                            await Clipboard.setData(
                                              ClipboardData(text: translatedText)
                                            )
                                              .then(
                                              (_) => ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    '클립보드에 복사되었습니다.',
                                                    textAlign: TextAlign.start,
                                                  )
                                                )
                                              )
                                            );
                                          },
                                        ),
                                        Text(
                                          '${appState.targetLanguage.name} / ${appState.targetLanguage.native_name}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                                : Container()
                              ]
                            )
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      FocusScope.of(context).hasFocus
                      ? FocusScope.of(context).unfocus()
                      : FocusScope.of(context).requestFocus();
                    }
                  ),
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
      ),
    );
  }
}
