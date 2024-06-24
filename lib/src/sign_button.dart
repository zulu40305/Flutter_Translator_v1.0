import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/app_state.dart';
import './rounded_button.dart';

class SignButton extends StatelessWidget {
  const SignButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => RoundedButton(
        width: 150,
        content: appState.loggedIn ? '로그아웃' : '로그인',
        function: () async { 
          await appState.signFunc();
          if (context.mounted) { Navigator.pop(context); }
        },
        textColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 65, 105, 225),
        fontSize: 14,
        fontWeight: FontWeight.w500,
        borderRadius: 30,
      )
    );
  }
}