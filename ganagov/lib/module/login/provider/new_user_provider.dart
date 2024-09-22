import 'dart:io';

import 'package:flutter/material.dart';

class NewUserProvider extends ChangeNotifier {
  GlobalKey<FormState> key = GlobalKey();
  DateTime dateTime = DateTime.now();
  String typeId = "";
  String departm = "";
  String genero = "";
  File? img;

  TextEditingController name = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController numberCC = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
}
