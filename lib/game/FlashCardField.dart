import 'package:flutter/material.dart';

class FlashCardField extends StatelessWidget {
  const FlashCardField({
    required this.fieldController,
    required this.fieldName,
    super.key
  });

  final TextEditingController fieldController;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: const TextStyle(
          fontSize: 14.0,
          color: Color.fromARGB(255, 65, 105, 225)
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 65, 105, 225), width: 1.0),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
    );
  }
}