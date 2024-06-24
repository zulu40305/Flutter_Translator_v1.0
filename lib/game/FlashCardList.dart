import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translator_testing/controller/app_state.dart';
import 'package:translator_testing/controller/show_confirm.dart';
import 'package:translator_testing/game/FlashCardFolder.dart';
import 'package:translator_testing/src/drawer.dart';

class FlashCardList extends StatefulWidget {
  const FlashCardList({super.key});

  @override
  State<FlashCardList> createState() => _FlashCardListState();
}

class _FlashCardListState extends State<FlashCardList> {
  bool onDelete = false;

  List<Stack> _buildGridContents(BuildContext context, List<dynamic> flashcard_list, void Function(String id) deleteFunc) {
    if (flashcard_list.isEmpty) { return const <Stack>[]; }

    return flashcard_list.map((flashcard) {
      return Stack(
        children: [
          Positioned(
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlashCardFolder(
                        flashcard_name: flashcard['name'],
                        flashcard_ID: flashcard['id'],
                        flashcards: flashcard['cards']
                      )
                    ),
                  );
                  setState(() {
                    onDelete = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          child: const Icon(
                            Icons.folder,
                            color: Color.fromARGB(200, 65, 105, 225),
                            size: 40.0,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          flashcard['name'],
                          style: const TextStyle(color: Color.fromARGB(255, 65, 105, 225)),
                        )
                      ],
                    )
                  )
                ),
              )
            ),
          ),
          onDelete
          ? Positioned(
            top:  0.0,
            right: 0.0,
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: IconButton(
                padding: EdgeInsets.zero,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20.0
                ),
                onPressed: () {
                  showConfirmDialog(
                    context,
                    '${flashcard['name']}를 삭제하시겠습니까?',
                    flashcard['id'],
                    deleteFunc
                  );
                }
              ),
            )
          )
          : Container()
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '플래시카드 폴더',
            style: TextStyle(
              color: Color.fromARGB(255, 65, 105, 225)
            )
          ),
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 105, 225)),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                addFlashcardFolderDialog(context, appState.addFlashCardFolder);
              },
            )
          ],
        ),
        floatingActionButton: SizedBox(
          width: 70.0,
          height: 70.0,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 65, 105, 225),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Icon(
              !onDelete
              ? Icons.delete_outline_outlined
              : Icons.close,
              color: Colors.white,
              size: 35.0
            ),
            onPressed: () {
              setState(() {
                onDelete = !onDelete;
              });
            },
          )
        ),
        drawer: const DrawerLayout(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(20.0),
                    childAspectRatio: 8.0 / 8.0,
                    children: _buildGridContents(context, appState.flashcards, appState.deleteFlashCardList),
                  )
                )
              ),
            ],
          )
        )
      )
    );
  }
}