import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final IconData? prefixIcon;
  final Color fillColor;
  final Color iconColor;
  final Color borderColor;
  final double borderRadius;
  final bool isPassword;
  final double sizeText;

  const CustomTextForm({
    super.key,
    required this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.prefixIcon,
    this.fillColor = const Color.fromARGB(255, 244, 244, 244),
    this.borderColor = const Color.fromARGB(255, 200, 200, 200),
    this.borderRadius = 10.0,
    this.isPassword = false,
    this.iconColor = const Color.fromARGB(255, 249, 188, 99),
    this.sizeText = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: sizeText),
          hintText: hintText,
          filled: true,
          fillColor: fillColor,
          prefixIcon:
              prefixIcon != null ? Icon(prefixIcon, color: iconColor) : null,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      ),
    );
  }
}
