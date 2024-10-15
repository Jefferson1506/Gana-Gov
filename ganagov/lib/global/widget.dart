import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class NotifyDialog {
  void dismmisDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showSuccessDialog(BuildContext context) {
    Dialogs.materialDialog(
      context: context,
      barrierColor: Colors.black38,
      title: "¡Éxito!",
      msg: "La operación se ha realizado con éxito.",
      color: Colors.white,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'OK',
          iconData: Icons.check_circle,
          color: Colors.green,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  static void showErrorDialog(BuildContext context, String text) {
    Dialogs.materialDialog(
      context: context,
      title: "Error",
      msg: text,
      color: Colors.white,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'Cerrar',
          iconData: Icons.error,
          color: Colors.red,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  static void showWarningDialog(BuildContext context, String text) {
    Dialogs.materialDialog(
      context: context,
      title: "Advertencia",
      msg: text,
      color: Colors.white,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'Continuar',
          iconData: Icons.warning,
          color: Colors.orange,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class LoadingDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Center(
                child: SpinKitFoldingCube(
                  color: const Color.fromARGB(255, 165, 245, 67),
                  size: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void dismissLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
