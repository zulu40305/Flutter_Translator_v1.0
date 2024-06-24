import 'package:flutter/material.dart';
import 'package:translator_testing/game/FlashCardField.dart';
import 'package:translator_testing/game/FlashCardList.dart';

void showConfirmDialog(BuildContext context, String dialogContent, String id, void Function(String id) function) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(dialogContent),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 65, 105, 225)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 55.0,
                  height: 20.0,
                  child: Center(
                    child: Text(
                      '취소',
                      style: TextStyle(
                        color: Colors.white
                      )
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 55.0,
                  height: 20.0,
                  child: Center(
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 105, 225)
                      )
                    )
                  ),
                ),
                onPressed: () {
                  function(id);
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      );
    }
  );
}

void addFlashcardFolderDialog(BuildContext context, void Function(String name) function) {
  final _folderFormKey = GlobalKey<FormState>();
  final _controller_name = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FlashCardField(
              fieldController: _controller_name, 
              fieldName: '폴더명 / Folder title'
            )
          ],
        ),
        actions: [
          Form(
            key: _folderFormKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 65, 105, 225)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    width: 55.0,
                    height: 20.0,
                    child: Center(
                      child: Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.white
                        )
                      )
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    width: 55.0,
                    height: 20.0,
                    child: Center(
                      child: Text(
                        '확인',
                        style: TextStyle(
                          color: Color.fromARGB(255, 65, 105, 225)
                        )
                      )
                    ),
                  ),
                  onPressed: () {
                    function(_controller_name.text);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          )
        ],
      );
    }
  );
}

void cardDeleteDialog(BuildContext context, String dialogContent, String folder_id, String card_id, void Function(String folder_id, String card_id) function) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(dialogContent),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 65, 105, 225)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 55.0,
                  height: 20.0,
                  child: Center(
                    child: Text(
                      '취소',
                      style: TextStyle(
                        color: Colors.white
                      )
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 55.0,
                  height: 20.0,
                  child: Center(
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Color.fromARGB(255, 65, 105, 225)
                      )
                    )
                  ),
                ),
                onPressed: () {
                  function(folder_id, card_id);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const FlashCardList()),
                    (route) => false
                  );
                },
              ),
            ],
          )
        ],
      );
    }
  );
}