// ignore_for_file: library_private_types_in_public_api

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Stack(
          alignment: Alignment.center,
          children: [
            AnimatedLogo(),
            Positioned(
              bottom: -10,
              child: AnimatedText(),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 3.5,
        height: MediaQuery.of(context).size.height * 3.5,
        child: Image.asset("assets/Logo.png", fit: BoxFit.cover),
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: AutoSizeText.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Gana",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 54, 54, 54)),
              ),
              TextSpan(
                text: "Gov",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
          maxLines: 1,
          minFontSize: 18,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
