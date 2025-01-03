import 'package:flutter/material.dart';
import 'package:ganagov/global/user_model.dart';
import 'package:ganagov/global/widgets/backgraound.dart';
import 'package:ganagov/global/widgets/loanding.dart';
import 'package:ganagov/global/widgets/notify_dialog.dart';
import 'package:ganagov/global/widgets/text_form.dart';
import 'package:ganagov/module/admin/page/home_admin.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PerfilBuyer extends StatefulWidget {
  const PerfilBuyer({super.key});

  @override
  State<PerfilBuyer> createState() => _PerfilBuyerState();
}

class _PerfilBuyerState extends State<PerfilBuyer> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _fechaController;
  late TextEditingController _idNumberController;
  late TextEditingController _idTypeController;
  late TextEditingController _nombreController;
  late TextEditingController _sexoController;
  late TextEditingController _telefonoController;

  Box<UserModel>? _userBox;
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _userBox = Hive.box<UserModel>('users');
    if (_userBox!.isNotEmpty) {
      _userModel = _userBox!.getAt(0);
      _initializeControllers();
    }
  }

  void _initializeControllers() {
    setState(() {
      _usernameController =
          TextEditingController(text: _userModel?.username ?? "");
      _emailController = TextEditingController(text: _userModel?.correo ?? "");
      _fechaController = TextEditingController(text: _userModel?.fecha ?? "");
      _idNumberController =
          TextEditingController(text: _userModel?.idNumber ?? "");
      _idTypeController = TextEditingController(text: _userModel?.idType ?? "");
      _nombreController = TextEditingController(text: _userModel?.nombre ?? "");
      _sexoController = TextEditingController(text: _userModel?.sexo ?? "");
      _telefonoController =
          TextEditingController(text: _userModel?.telefono ?? "");
    });
  }

  Future<String?> getUserIdByUsername(
      BuildContext context, String username) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('idNumber', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        NotifyDialog.showWarningDialog(context, "Usuario no encontrado");

        return null;
      }
    } catch (error) {
      NotifyDialog.showErrorDialog(
          context, "Error al buscar el usuario: $error");

      return null;
    }
  }

  Future<void> updateUserData(BuildContext context) async {
    LoadingDialog.showLoadingDialog(context);

    if (_userModel != null) {
      String? userId =
          await getUserIdByUsername(context, _userModel!.idNumber.toString());

      if (userId != null) {
        try {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .update({
            'User': _usernameController.text,
            'correo': _emailController.text,
            'fecha': _fechaController.text,
            'idNumber': _idNumberController.text,
            'idType': _idTypeController.text,
            'nombre': _nombreController.text,
            'sexo': _sexoController.text,
            'telefono': _telefonoController.text,
          });

          _userModel = UserModel(
            username: _usernameController.text,
            correo: _emailController.text,
            fecha: _fechaController.text,
            idNumber: _idNumberController.text,
            idType: _idTypeController.text,
            nombre: _nombreController.text,
            sexo: _sexoController.text,
            telefono: _telefonoController.text,
            password: _userModel!.password,
            role: _userModel!.role,
            estado: _userModel!.estado,
            superAdmin: _userModel!.superAdmin,
          );

          if (_userBox!.isNotEmpty) {
            await _userBox!.putAt(0, _userModel!);
          } else {
            await _userBox!.add(_userModel!);
          }
          LoadingDialog.dismissLoadingDialog(context);
          NotifyDialog.showSuccessDialog(context);
        } catch (e) {
          LoadingDialog.dismissLoadingDialog(context);
          NotifyDialog.showErrorDialog(
              context, "Error al actualizar datos: $e");
        }
      } else {
        LoadingDialog.dismissLoadingDialog(context);
        NotifyDialog.showErrorDialog(
            context, "El usuario no existe en la base de datos.");
      }
    }
  }

  Widget _buildCircleAvatar() {
    String initials = _userModel?.nombre?.isNotEmpty ?? false
        ? _userModel!.nombre!.substring(0, 2).toUpperCase()
        : "??";
    return CircleAvatar(
      radius: 40,
      backgroundColor: const Color.fromARGB(255, 249, 188, 99),
      child: AutoSizeText(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const UnderlineInputBorder(
          borderSide: BorderSide(
              color:  Color.fromARGB(255, 165,217,24), width: 5),
        ),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
        title: const AutoSizeText(
          "Perfil de Usuario",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => logout(context),
              icon: const Icon(
                Icons.people,
                color: Colors.red,
              )),
          IconButton(
              onPressed: () => exitApp(),
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.orange,
              ))
        ],
      ),
      body: _userModel == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(children: [
              backgroundAfternoon(context),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _buildCircleAvatar(),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 218, 218, 218),
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: MediaQuery.sizeOf(context).height * 0.07,
                          width: MediaQuery.sizeOf(context).width * 0.03,
                          child: buildTextIconRow(
                              icon: Icons.document_scanner,
                              color: Colors.black,
                              text: 'Cedula  - ${_idNumberController.text}'),
                        )),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 218, 218, 218),
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: MediaQuery.sizeOf(context).height * 0.07,
                          width: MediaQuery.sizeOf(context).width * 0.03,
                          child: buildTextIconRow(
                              icon: Icons.person,
                              color: Colors.black,
                              text: 'Nombre - ${_nombreController.text}'),
                        )),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 218, 218, 218),
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: MediaQuery.sizeOf(context).height * 0.07,
                          width: MediaQuery.sizeOf(context).width * 0.03,
                          child: buildTextIconRow(
                              icon: Icons.email,
                              color: Colors.black,
                              text: 'Correo - ${_emailController.text}'),
                        )),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 218, 218, 218),
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: MediaQuery.sizeOf(context).height * 0.07,
                          width: MediaQuery.sizeOf(context).width * 0.03,
                          child: buildTextIconRow(
                              icon: Icons.calendar_today_outlined,
                              color: Colors.black,
                              text:
                                  'Fecha nacimiento - ${_fechaController.text}'),
                        )),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 218, 218, 218),
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: MediaQuery.sizeOf(context).height * 0.07,
                          width: MediaQuery.sizeOf(context).width * 0.03,
                          child: buildTextIconRow(
                              icon: Icons.person_outlined,
                              color: Colors.black,
                              text: 'Sexo - ${_sexoController.text}'),
                        )),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                    CustomTextForm(
                      iconColor: Colors.black,
                      controller: _usernameController,
                      hintText: 'Usuario',
                      prefixIcon: Icons.account_circle,
                      validator: (value) =>
                          value!.isEmpty ? 'El usuario es requerido' : null,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                    CustomTextForm(
                      iconColor: Colors.black,
                      controller: _telefonoController,
                      hintText: 'Teléfono',
                      prefixIcon: Icons.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'El teléfono es requerido' : null,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                          backgroundColor:
                              const Color.fromARGB(255, 249, 188, 99),
                        ),
                        child: const Text(
                          'Guardar Cambios',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          await updateUserData(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
    );
  }
}

Widget buildTextIconRow(
    {required String text, IconData? icon, required Color color}) {
  return TextButton.icon(
    onPressed: () {},
    icon: icon != null
        ? Icon(icon, color: Colors.black, size: 16)
        : const SizedBox(),
    label: AutoSizeText(
      text,
      style: TextStyle(
        fontSize: 15,
        color: color,
      ),
    ),
  );
}
