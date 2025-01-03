import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/user_model.dart';
import 'package:ganagov/global/widgets/backgraound.dart';
import 'package:ganagov/global/widgets/button.dart';
import 'package:ganagov/module/login/page/login.dart';
import 'package:ganagov/term.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<String?> getUserRoleFromHive() async {
    var box = await Hive.openBox<UserModel>('users');

    if (box.isEmpty) {
      return null;
    }

    UserModel user = box.getAt(0)!;

    return user.role;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          backgroundDay(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo(context),
              CustomButton(
                origin: context,
                text: "Soy Vendedor",
                colorText: Colors.black,
                color: color.primary,
                onpress: () async {
                  String? role = await getUserRoleFromHive();
                  if (role != null) {
                    switch (role) {
                      case "ADMIN":
                        Navigator.pushReplacementNamed(context, "home_admin");
                        break;
                      case "USER":
                        Navigator.pushReplacementNamed(context, "home_buyer");
                        break;
                    }
                  } else {
                    Navigator.pushReplacementNamed(context, "login");
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
              CustomButton(
                origin: context,
                text: "Soy Comprador",
                colorText: Colors.black,
                color: color.secondary,
                onpress: () => Navigator.pushNamed(context, "home_seller"),
              ),
              TextButton.icon(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TerminosYCondicionesPage())),
                  label: AutoSizeText(
                    'Términos y condiciones de uso ',
                    maxFontSize: 17,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 17),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
