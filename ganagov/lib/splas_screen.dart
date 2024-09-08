// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ganagov/widgets/img.dart';
import 'package:ganagov/widgets/text_span.dart';

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
    return Center(child: imgLogo(context, 3.5));
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
    final colorScheme = Theme.of(context).colorScheme;

    return SlideTransition(
        position: _offsetAnimation,
        child: CustomTextSpan(
            primary: const Color.fromARGB(255, 54, 54, 54),
            secondary: colorScheme.primary,
            textPrimary: "Gana",
            textSecondary: "Gov",
            sizePrimary: 20,
            sizeSecondary: 20));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
