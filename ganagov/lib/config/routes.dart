import 'package:flutter/material.dart';
import 'package:ganagov/module/buyer/home_buyer.dart';
import 'package:ganagov/module/login/home_screen.dart';
import 'package:ganagov/module/login/login.dart';
import 'package:ganagov/module/login/recover_password.dart';
import 'package:ganagov/module/seller/home_seller.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "home": (_) => const HomeScreen(),
  "login": (_) => const Login(),
  "recover": (_) => const RecoverPassword(),
  "home_buyer": (_) => const HomeBuyer(),
  "home_seller": (_) => const HomeSeller()
};
