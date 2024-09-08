import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final double sizeWidth;
  final double sizeHeight;
  final double sizeText;
  final Color color;
  final Color colorText;
  final BuildContext origin;
  final VoidCallback onpress;

  const CustomButton({
    super.key,
    required this.text,
    this.sizeWidth = 0.9,  // Ancho del botón en proporción a la pantalla
    this.sizeHeight = 0.08, // Alto del botón en proporción a la pantalla
    this.sizeText = 17, // Tamaño de texto
    required this.color,
    this.colorText = Colors.white,
    required this.origin,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(origin).width * sizeWidth,
        height: MediaQuery.sizeOf(origin).height * sizeHeight,
        child: ElevatedButton(
          onPressed: onpress,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Bordes redondeados
            ),
          ),
          child: AutoSizeText(
            text,
            style: TextStyle(color: colorText, fontSize: sizeText),
            textAlign: TextAlign.center, // Alineación de texto centrada
          ),
        ),
      ),
    );
  }
}
