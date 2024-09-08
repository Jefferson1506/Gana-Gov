// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ganagov/module/login/home_screen.dart';
import 'package:ganagov/module/login/login.dart';
import 'package:ganagov/splas_screen.dart';
import 'package:ganagov/widgets/backgraound.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: colorScheme(),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: const SplashScreenContent(),
        nextScreen: Login(),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white,
        splashIconSize: 100,
      ),
    );
  }
}

ThemeData colorScheme() {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 244, 244, 244),
        primary: const Color.fromARGB(255, 165, 245, 67),
        secondary: const Color.fromARGB(255, 249, 188, 99),
        tertiary: const Color.fromARGB(255, 54, 54, 54),
        surface: const Color.fromARGB(255, 244, 244, 244),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      )));
}
