// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ganagov/module/login/home_screen.dart';
import 'package:ganagov/splas_screen.dart';
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
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: const SplashScreenContent(),
        nextScreen: const HomeScreen(),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white,
        splashIconSize: 100,
      ),
    );
  }
}
