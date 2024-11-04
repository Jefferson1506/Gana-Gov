// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ganagov/global/routes.dart';
import 'package:ganagov/firebase_options.dart';
import 'package:ganagov/global/user_model.dart';
import 'package:ganagov/module/login/page/home_screen.dart';
import 'package:ganagov/splas_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox<UserModel>('users');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: colorScheme(),
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

ThemeData colorScheme() {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 244, 244, 244),
        primary: const Color.fromARGB(255, 165, 217, 24),
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
