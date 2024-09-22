import 'package:flutter/material.dart';
import 'package:ganagov/module/login/services/login_services.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  void obscureAlt() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void submit(BuildContext context) async {
    if (keyForm.currentState?.validate() ?? false) {
      final user = await verifyUserCredentials(
          userController.text.toString().trim(),
          passwordController.text.toString().trim(),
          context);

      if (user != null) {
        switch (user) {
          case "ADMIN":
            Navigator.pushReplacementNamed(context, "home_admin");
            break;
          case "USER":
            Navigator.pushReplacementNamed(context, "home_buyer");
            break;
        }
      }
    }
  }
}
