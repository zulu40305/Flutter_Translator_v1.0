import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    required this.borderColor,
    required this.backgroundColor,
    required this.iconColor,
    required this.buttonIcon,
    this.iconSize,
    this.width,
    this.height,
    this.padding = 5,
    this.borderWidth = 1,
    required this.function,
    super.key
  });

  final Color borderColor;
  final Color backgroundColor;
  final Color iconColor;
  final IconData buttonIcon;
  final double? iconSize;
  final double? width;
  final double? height;
  final double padding;
  final double borderWidth;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(300),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Icon(
          buttonIcon,
          color: iconColor,
          size: iconSize,
        ),
      ),
      onPressed: function,
    );
  }
}