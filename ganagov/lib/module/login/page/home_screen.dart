import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/backgraound.dart';
import 'package:ganagov/global/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
        body: Stack(children: [
      backgroundDay(context),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            origin: context,
            text: "Soy Vendedor",
            color: color.primary,
            onpress: () => Navigator.pushNamed(context, "login"),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          CustomButton(
            origin: context,
            text: "Soy Comprador",
            color: color.secondary,
            onpress: () => Navigator.pushNamed(context, "home_buyer"),
          )
        ],
      ),
    ]));
  }
}
