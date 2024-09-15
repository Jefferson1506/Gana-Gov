import 'package:flutter/material.dart';

class RecoverProvaider extends ChangeNotifier {
  bool visibilyUser = true;
  bool visibilyPassword = false;

  TextEditingController email = TextEditingController();
  TextEditingController newPassword1 = TextEditingController();
  TextEditingController newPassword2 = TextEditingController();

  GlobalKey<FormState> key1 = GlobalKey();
  GlobalKey<FormState> key2 = GlobalKey();

  void visibilityWidget() {
    visibilyUser = !visibilyUser;
    visibilyPassword = !visibilyPassword;
    notifyListeners();
  }

    @override
  void dispose() {
    email.dispose();
    newPassword1.dispose();
    newPassword2.dispose();
    super.dispose();
  }
}
