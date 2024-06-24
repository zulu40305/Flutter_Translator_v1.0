import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/model/language_data.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  void showLanguageSelector(
    double height,
    BuildContext context,
    AppState appState,
    String type,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
          ),
          padding: const EdgeInsets.only(top: 30.0),
          height: height,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      '언어 선택',
                      style: TextStyle(
                        fontSize: 16.0
                      )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration( 
                        border: Border.all(color: const Color.fromARGB(255, 65, 105, 225), width: 1),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListView(
                        children: languages.map<Widget>((language) => Column(
                          children: [
                            TextButton(
                              onPressed: () async {
                                if (language.isDownloaded && !language.isDownloading) {
                                  type == 'sourceLanguage'
                                  ? appState.selectSourceLanguage(language)
                                  : appState.selectTargetLanguage(language);
                                  Navigator.pop(context);
                                } else {
                                  if (!language.isDownloading) { 
                                    await appState.downloadLanguageModel(language); 
                                  }
                                }
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 35.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${language.name} / ${language.native_name}',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 65, 105, 225),
                                        fontWeight: FontWeight.w500
                                      )
                                    ),
                                    !language.isDownloaded || language.isDownloading
                                    ? language.isDownloading
                                    ? const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 17.0),
                                      child: SizedBox(
                                        width: 15.0,
                                        height: 15.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.8,
                                          color: Color.fromARGB(255, 65, 105, 225),
                                        )
                                      )
                                    )
                                    : IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.download_sharp,
                                        size: 20.0,
                                        color: Color.fromARGB(255, 65, 105, 225)
                                      ),
                                      onPressed: () async {
                                        await appState.downloadLanguageModel(language);
                                      },
                                    )
                                    : Container()
                                  ]
                                )
                              ),
                            ),
                            const Divider(
                              color: Color.fromARGB(255, 65, 105, 225),
                              thickness: 0.3,
                              indent: 10,
                              endIndent: 10,
                            )
                          ],
                        )).toList()
                      ),
                    )
                  )
                ],
              )
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 48.0,
        decoration: BoxDecoration( 
          color:const Color.fromARGB(175, 255, 255, 255),
          border: Border.all(color: const Color.fromARGB(255, 65, 105, 225), width: 2.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text(
                appState.sourceLanguage.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 65, 105, 225)
                )
              ),
              onPressed: () {
                showLanguageSelector(MediaQuery.of(context).size.height * 0.9, context, appState, 'sourceLanguage');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.compare_arrows_rounded,
                color: Color.fromARGB(255, 65, 105, 225),
                size: 30.0
              ),
              onPressed: () {
                appState.switchLanguage();
              },
            ),
            TextButton(
              child: Text(
                appState.targetLanguage.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 65, 105, 225)
                )
              ),
              onPressed: () {
                showLanguageSelector(MediaQuery.of(context).size.height * 0.9, context, appState, 'targetLanguage');
              },
            ),
          ]
        ),
      )
    );
  }
}