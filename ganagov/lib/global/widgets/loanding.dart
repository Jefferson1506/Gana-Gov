import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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