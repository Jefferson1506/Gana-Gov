import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/widget.dart';
import 'package:ganagov/module/login/model/user.dart';

Future<String?> verifyUserCredentials(
    String username, String password, BuildContext context) async {
  try {
    LoadingDialog.showLoadingDialog(context);

    final userDocs = await FirebaseFirestore.instance.collection('Users').get();

    LoadingDialog.dismissLoadingDialog(context);

    List<UserModel> users =
        userDocs.docs.map((doc) => UserModel.fromMap(doc.data())).toList();

    UserModel? foundUser = users.firstWhere(
      (user) => user.username == username,
    );

    print(foundUser.username + " " + foundUser.password);
    
    print(username + " " + password);

    if (foundUser.password == password) {
      NotifyDialog.showSuccessDialog(context);
      return foundUser.role;
    } else {
      NotifyDialog.showErrorDialog(context, "Contraseña incorrecta");
    }
  } catch (e) {
    NotifyDialog.showErrorDialog(
        context, 'Error al verificar credenciales: $e');
  }

  return null;
}
