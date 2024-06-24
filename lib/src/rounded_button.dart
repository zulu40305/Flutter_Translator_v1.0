import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.content,
    required this.function,
    required this.textColor,
    required this.backgroundColor,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w500,
    this.width,
    this.height,
    this.borderRadius = 10,
    super.key,
  });

  final String content;
  final VoidCallback function;
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )
        ),
        onPressed: function,
        child: Text(
          content,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight
          ),
        ),
      )
    );
  }
}