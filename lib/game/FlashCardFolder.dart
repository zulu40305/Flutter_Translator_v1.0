import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/controller/show_confirm.dart';
import 'package:translator_testing/game/FlashCardEdit.dart';
import 'package:translator_testing/game/FlashCardForm.dart';
import 'package:translator_testing/game/FlashCardLearning.dart';

class FlashCardFolder extends StatelessWidget {
  const FlashCardFolder({required this.flashcard_name, required this.flashcard_ID, required this.flashcards, super.key});

  final String flashcard_name;
  final String flashcard_ID;
  final List<dynamic> flashcards;

  List<Stack> _buildGridContents(BuildContext context, List<dynamic> flashcards, void Function(String folder_id, String card_id) deleteFunc) {
    if (flashcards.isEmpty) { return const <Stack>[]; }

    return flashcards.map((flashcard) {
      return Stack(
        children: [
          Positioned(
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '딘어 / word',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 105, 225),
                                      fontSize: 10.0
                                    ),
                                  ),
                                  Text(
                                    flashcard['word'],
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '의미 / meaning',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 105, 225),
                                      fontSize: 10.0
                                    ),
                                  ),
                                  Text(
                                    flashcard['meaning'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 65, 105, 225),
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18.0
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FlashCardEdit(
                                        id: flashcard['id'],
                                        word: flashcard['word'],
                                        meaning: flashcard['meaning'],
                                        synonym: flashcard['synonym'],
                                        antonym: flashcard['antonym'],
                                      )
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.white,
                                  size: 18.0
                                ),
                                onPressed: () {
                                  cardDeleteDialog(
                                    context,
                                    '${flashcard['word']} 플래시카드를 삭제하시겠습니까?',
                                    flashcard_ID,
                                    flashcard['id'],
                                    deleteFunc
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  )
                )
              )
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            flashcard_name,
            style: const TextStyle(
              color: Color.fromARGB(255, 65, 105, 225)
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlashCardForm(flashcard_ID: flashcard_ID)
                  ),
                );
              },
            )
          ],
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 105, 225)),
        ),
        floatingActionButton: SizedBox(
          width: 70.0,
          height: 70.0,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 65, 105, 225),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 35.0
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FlashCardLearning(
                    flashcard_name: flashcard_name,
                    flashcards: flashcards
                  )
                ),
              );
            },
          )
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(15.0),
                    childAspectRatio: 12.0 / 9.0,
                    children: _buildGridContents(context, flashcards, appState.deleteFlashCard),
                  )
                ),
              ],
            )
          ),
        )
      )
    );
  }
}