import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color colorText;
  final double sizeText;
  final TextAlign textAlign;
  final bool bold;
  final int maxLines;

  const CustomText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.maxLines = 1,
    this.colorText = Colors.black,
    this.sizeText = 17,
    this.bold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(
        color: colorText,
        fontSize: sizeText,
        fontWeight: bold != false ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
