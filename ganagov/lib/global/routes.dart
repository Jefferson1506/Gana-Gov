import 'package:flutter/material.dart';
import 'package:ganagov/module/admin/page/home_admin.dart';
import 'package:ganagov/module/buyer/page/home_buyer.dart';
import 'package:ganagov/module/login/page/home_screen.dart';
import 'package:ganagov/module/login/page/login.dart';
import 'package:ganagov/module/login/page/new_user.dart';
import 'package:ganagov/module/login/page/recover_password.dart';
import 'package:ganagov/module/seller/home_seller.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "home": (_) => const HomeScreen(),
  "login": (_) => const Login(),
  "new_user": (_) => const NewUser(),
  "recover": (_) => const RecoverPassword(),
  "home_buyer": (_) => const HomeBuyer(),
  "home_seller": (_) => SalesView(),
  "home_admin": (_) => const AdminHomePage(),
};
