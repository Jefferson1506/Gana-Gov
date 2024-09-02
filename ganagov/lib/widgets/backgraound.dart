
import 'package:flutter/material.dart';

Widget background(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Stack(
    children: [
      Positioned(
        bottom: height * -0.06,
        left: width * -0.012,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 255, 145, 76),
        ),
      ),
       Positioned(
        bottom: height * -0.1,
        left: width * -0.15,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 192, 255, 114),
        ),
      ),
        Positioned(
        bottom: height * -0.13,
        left: width * 0.13,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 192, 255, 114),
        ),
      )
    ],
  );
}