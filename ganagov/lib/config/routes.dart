import 'package:flutter/material.dart';
import 'package:ganagov/page/buyer/home_buyer.dart';
import 'package:ganagov/page/login/home_screen.dart';
import 'package:ganagov/page/login/login.dart';
import 'package:ganagov/page/login/recover_password.dart';
import 'package:ganagov/page/seller/home_seller.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "home": (_) => const HomeScreen(),
  "login": (_) => const Login(),
  "recover": (_) => const RecoverPassword(),
  "home_buyer": (_) => const HomeBuyer(),
  "home_seller": (_) => const HomeSeller()
};
