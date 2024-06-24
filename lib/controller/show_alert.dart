import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String dialogContent) {
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
          TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 65, 105, 225))
            ),
            child: const Center(
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.white
                )
              )
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
  );
}