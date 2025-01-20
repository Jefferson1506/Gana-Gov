import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomTextSpan extends StatelessWidget {
  final Color primary;
  final Color secondary;
  final String textPrimary;
  final String textSecondary;
  final double sizePrimary;
  final double sizeSecondary;
  const CustomTextSpan(
      {super.key,
      required this.primary,
      required this.secondary,
      required this.textPrimary,
      required this.textSecondary,
      required this.sizePrimary,
      required this.sizeSecondary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: AutoSizeText.rich(
        TextSpan(
          children: [
            TextSpan(
                text: textPrimary,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizePrimary,
                  color: primary,
                )),
            TextSpan(
                text: textSecondary,
                style: TextStyle(
                  fontSize: sizeSecondary,
                  fontWeight: FontWeight.bold,
                  color: secondary,
                )),
          ],
        ),
        maxLines: 1,
        minFontSize: 18,
        maxFontSize: 19,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
