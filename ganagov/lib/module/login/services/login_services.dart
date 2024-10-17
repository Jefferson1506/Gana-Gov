import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/user_model.dart';
import 'package:ganagov/global/widgets/notify_dialog.dart';
import 'package:hive/hive.dart';

import '../../../global/widgets/loanding.dart';

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

    if (foundUser.password == password) {
      if (foundUser.estado!.contains('SI')) {
        final userBox = Hive.box<UserModel>('users');
        await userBox.put(username, foundUser);

        return foundUser.role;
      } else {
        NotifyDialog.showWarningDialog(context, "Usuario No Activo");
      }
    } else {
      NotifyDialog.showErrorDialog(context, "Contraseña incorrecta");
    }
  } catch (e) {
    NotifyDialog.showWarningDialog(
        context, 'Error al verificar credenciales: \n$e');
  }

  return null;
}
