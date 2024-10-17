import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/loanding.dart';
import 'package:ganagov/global/widgets/notify_dialog.dart';

class NewAdminProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController userController = TextEditingController();
  final TextEditingController claveController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController estadoController =
      TextEditingController(text: 'SI');

  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    }
    return false;
  }

  void registerAdmin(BuildContext context) async {
    LoadingDialog.showLoadingDialog(context);

    final String user = userController.text.trim();
    final String clave = claveController.text.trim();
    final String correo = correoController.text.trim();
    final String estado = estadoController.text.trim();

    if (user.isEmpty || clave.isEmpty || correo.isEmpty || estado.isEmpty) {
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showWarningDialog(
          context, "Todos los campos son obligatorios.");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Users').add({
        'User': user,
        'clave': clave,
        'correo': correo,
        'Estado': estado,
        'rol': 'ADMIN',
      });

      LoadingDialog.dismissLoadingDialog(context);

      NotifyDialog.showSuccessDialog(context);

      userController.clear();
      claveController.clear();
      correoController.clear();
      estadoController.clear();
    } catch (error) {
      LoadingDialog.dismissLoadingDialog(context);

      NotifyDialog.showErrorDialog(
          context, "Hubo un error al registrar el admin: ${error.toString()}");
    }
  }

  @override
  void dispose() {
    userController.dispose();
    claveController.dispose();
    correoController.dispose();
    estadoController.dispose();
    super.dispose();
  }
}
