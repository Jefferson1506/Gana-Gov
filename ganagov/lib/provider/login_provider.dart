import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;



  void obscureAlt() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void submit() {
    if (keyForm.currentState?.validate() ?? false) {}
  }
}
