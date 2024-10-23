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

          NotifyDialog.showSuccessDialog(context);
        } catch (e) {
          NotifyDialog.showErrorDialog(
              context, "Error al actualizar datos: $e");
        }
      } else {
        NotifyDialog.showErrorDialog(
            context, "El usuario no existe en la base de datos.");
      }
    }

    LoadingDialog.dismissLoadingDialog(context);
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
          borderSide:
              BorderSide(color: Color.fromARGB(255, 17, 163, 3), width: 5),
        ),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
        title: const AutoSizeText(
          "Perfil de Usuario",
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
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          height: MediaQuery.sizeOf(context).height * 0.07,
                          width: MediaQuery.sizeOf(context).width * 0.03,
                          child: AutoSizeText(
                              maxFontSize: 19,
                              minFontSize: 17,
                              textAlign: TextAlign.center,
                              '${_idTypeController.text.toString()} - ${_idNumberController.text.toString()}')),
                    ),
                    CustomTextForm(
                      iconColor: Colors.black,
                      controller: _nombreController,
                      hintText: 'Nombre',
                      prefixIcon: Icons.person,
                      validator: (value) =>
                          value!.isEmpty ? 'El nombre es requerido' : null,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    CustomTextForm(
                      iconColor: Colors.black,
                      controller: _usernameController,
                      hintText: 'Usuario',
                      prefixIcon: Icons.account_circle,
                      validator: (value) =>
                          value!.isEmpty ? 'El usuario es requerido' : null,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    CustomTextForm(
                      iconColor: Colors.black,
                      controller: _emailController,
                      hintText: 'Correo',
                      prefixIcon: Icons.email,
                      validator: (value) =>
                          value!.isEmpty ? 'El correo es requerido' : null,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    CustomTextForm(
                      iconColor: Colors.black,
                      controller: _fechaController,
                      hintText: 'Fecha de Registro',
                      prefixIcon: Icons.calendar_today,
                      validator: (value) =>
                          value!.isEmpty ? 'La fecha es requerida' : null,
                      keyboardType: TextInputType.datetime,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    CustomTextForm(
                      iconColor: Colors.black,
                      controller: _sexoController,
                      hintText: 'Sexo',
                      prefixIcon: Icons.person_outline,
                      validator: (value) =>
                          value!.isEmpty ? 'El sexo es requerido' : null,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
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
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * 0.03,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 249, 188, 99),
                        ),
                        child: const Text(
                          'Guardar Cambios',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          await updateUserData(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ]),
    );
  }
}
