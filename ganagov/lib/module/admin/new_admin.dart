import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/button.dart';
import 'package:ganagov/global/widgets/text_form.dart';
import 'package:ganagov/module/admin/provider/new_admin_provider.dart';
import 'package:provider/provider.dart';

class NewAdmin extends StatelessWidget {
  const NewAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 48, 39),
      body: ChangeNotifierProvider(
        create: (_) => NewAdminProvider(),
        child: const _NewAdminForm(),
      ),
    );
  }
}

class _NewAdminForm extends StatelessWidget {
  const _NewAdminForm();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewAdminProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: provider.formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextForm(
                controller: provider.userController,
                hintText: 'Usuario (ADMIN)',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextForm(
                controller: provider.claveController,
                hintText: 'Clave',
                prefixIcon: Icons.lock,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La clave es obligatoria';
                  } else if (value.length < 4) {
                    return 'La clave debe tener al menos 4 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextForm(
                controller: provider.correoController,
                hintText: 'Correo',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El correo es obligatorio';
                  } 
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextForm(
                controller: provider.estadoController,
                hintText: 'Estado (SI)',
                prefixIcon: Icons.check_circle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Registrar Admin',
                color: Colors.orange,
                origin: context,
                onpress: () {
                  if (provider.validateForm()) {
                    provider.registerAdmin(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
