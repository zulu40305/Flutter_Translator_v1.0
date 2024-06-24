import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:translator_testing/controller/app_state.dart';

class TranslatorSelector extends StatelessWidget {
  const TranslatorSelector({required this.function, super.key});

  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration( 
            color:const Color.fromARGB(255, 65, 105, 225),
            border: Border.all(color: const Color.fromARGB(255, 65, 105, 225), width: 3.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 48.0,
          alignment: Alignment.center,
          child: const Text(
            '메뉴 열기',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.0
            )
          ),
        ),
      ),
    );
  }
}