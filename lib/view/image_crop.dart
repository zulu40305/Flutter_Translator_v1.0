import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/controller/show_alert.dart';

class ImageTranslation extends StatefulWidget {
  const ImageTranslation({
    required this.image,
    required this.originalText, 
    required this.translatedText, 
    super.key
  });
  final XFile image;
  final String originalText;
  final String translatedText;

  @override
  State<ImageTranslation> createState() => _ImageTranslationState();
}

class _ImageTranslationState extends State<ImageTranslation> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Scaffold(
        appBar: AppBar(
          title: Text(appState.appTitle)
        ),
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15.0),
                    color: const Color.fromARGB(255, 65, 105, 225),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      decoration: BoxDecoration( 
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: 180,
                      height: 180,
                      child: Image.file(
                        File(widget.image.path),
                        fit: BoxFit.contain
                      )
                    ),
                  ),
                  const SizedBox(height: 15.0),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '원문',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 105, 225),
                                    )
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.volume_up,
                                          size: 18
                                        ),
                                        onPressed: () {
                                          if (appState.sourceLanguage.iso_language_code != null) {
                                            appState.useTTS(widget.originalText, appState.sourceLanguage);
                                          } else {
                                            print('haha');
                                            showAlertDialog(context, '해당 언어는 아직 읽기 기능을 지원하지 않습니다.');
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.copy,
                                          size: 18
                                        ),
                                        onPressed: () async {
                                          await Clipboard.setData(
                                                  ClipboardData(text: widget.originalText)
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
                                          fontSize: 12
                                        )
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ),
                            Text(
                              widget.originalText,
                              style: const TextStyle(
                                fontSize: 16.0
                              )
                            )
                          ],
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 15.0),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '번역문',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 105, 225),
                                    )
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.volume_up,
                                          size: 18
                                        ),
                                        onPressed: () {
                                          if (appState.targetLanguage.iso_language_code != null) {
                                            appState.useTTS(widget.translatedText, appState.targetLanguage);
                                          } else {
                                            showAlertDialog(context, '해당 언어는 아직 읽기 기능을 지원하지 않습니다.');
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.copy,
                                          size: 18
                                        ),
                                        onPressed: () async {
                                          await Clipboard.setData(
                                                  ClipboardData(text: widget.translatedText)
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
                                        )
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ),
                            Text(
                              widget.translatedText,
                              style: const TextStyle(
                                fontSize: 16.0
                              )
                            )
                          ],
                        )
                      )
                    )
                  )
                ],
              )
            )
          )
        )
      )
    );
  }
}