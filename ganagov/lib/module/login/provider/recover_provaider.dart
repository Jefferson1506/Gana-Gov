import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/loanding.dart';

class RecoverProvider extends ChangeNotifier {
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

  Future<void> changePassword(BuildContext context) async {
    if (!key1.currentState!.validate()) {
      return;
    }

    try {
      LoadingDialog.showLoadingDialog(context);

      String enteredEmail = email.text.trim();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('correo', isEqualTo: enteredEmail)
          .get();

      LoadingDialog.dismissLoadingDialog(context);

      if (querySnapshot.docs.isNotEmpty) {
        visibilityWidget();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Correo no encontrado")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text("Error al verificar el correo: $e")),
      );
    }
  }

  Future<void> updatePassword(BuildContext context) async {
    if (!key2.currentState!.validate()) {
      return;
    }

    try {
      LoadingDialog.showLoadingDialog(context);
      String enteredEmail = email.text.trim();
      String newPassword = newPassword1.text.trim();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('correo', isEqualTo: enteredEmail)
          .get();
      LoadingDialog.dismissLoadingDialog(context);
      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .update({'clave': newPassword});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Contraseña actualizada con éxito")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text("Error al actualizar la contraseña: $e")),
      );
    }
  }

  @override
  void dispose() {
    email.dispose();
    newPassword1.dispose();
    newPassword2.dispose();
    super.dispose();
  }
}
