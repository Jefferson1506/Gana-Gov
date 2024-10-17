import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/loanding.dart';
import 'package:ganagov/global/widgets/notify_dialog.dart';
import 'package:intl/intl.dart';
class UserProvider extends ChangeNotifier {



  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  String? selectedIdType; 
  String? selectedGender; 
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> key = GlobalKey();

  final List<String> idTypes = ['DNI', 'Pasaporte', 'Cédula', 'Otro'];
  final List<String> genders = ['Masculino', 'Femenino', 'Otro'];

  Future<void> registerUser(BuildContext context) async {
    LoadingDialog.showLoadingDialog(context);
    if (!key.currentState!.validate()) {
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showWarningDialog(context, "Todos los campos son obligatorios.");
      return;
    }

    try {
      await _firestore.collection('Users').add({
        'nombre': fullNameController.text,
        'User': usernameController.text,
        'fecha': birthdateController.text,
        'idType': selectedIdType,
        'idNumber': idNumberController.text,
        'telefono': phoneController.text,
        'sexo': selectedGender,
        'correo': emailController.text,
        'clave': passwordController.text,
        'Estado': 'NO',
        'rol': 'USER'
      });

      clearControllers();
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showSuccessDialog(context);
    } catch (e) {
      LoadingDialog.dismissLoadingDialog(context);
      NotifyDialog.showErrorDialog(context, "Error al registrar el usuario: ${e.toString()}");
    }
  }

  void clearControllers() {
    fullNameController.clear();
    usernameController.clear();
    birthdateController.clear();
    selectedIdType = null;
    idNumberController.clear();
    phoneController.clear();
    selectedGender = null;
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  void setIdType(String? value) {
    selectedIdType = value;
    notifyListeners();
  }

  void setGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  Future<void> selectBirthdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      notifyListeners();
    }
  }

  
}


