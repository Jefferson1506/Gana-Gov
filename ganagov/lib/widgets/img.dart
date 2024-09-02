import 'package:flutter/material.dart';

Widget imgLogo(BuildContext context, size) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * size,
    height: MediaQuery.of(context).size.height * size,
    child: Image.asset("assets/Logo.png", fit: BoxFit.cover),
  );
}
