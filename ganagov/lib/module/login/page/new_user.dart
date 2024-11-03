import 'package:flutter/material.dart';
import 'package:ganagov/module/login/provider/new_user_provider.dart';
import 'package:ganagov/global/widgets/backgraound.dart';
import 'package:ganagov/global/widgets/text_form.dart';
import 'package:ganagov/global/widgets/text_span.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewUser extends StatelessWidget {
  const NewUser({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: height * 0.1,
          backgroundColor: Colors.white,
          actions: [
            CustomTextSpan(
              primary: const Color.fromARGB(255, 54, 54, 54),
              secondary: colorScheme.primary,
              textPrimary: "Gana",
              textSecondary: "Gov",
              sizePrimary: 27,
              sizeSecondary: 27,
            ),
            SizedBox(width: width * 0.03),
          ],
        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            backgroundAfternoon(context),
            SingleChildScrollView(
              child: Consumer<UserProvider>(
                builder: (context, provider, child) {
                  return Form(
                    key: provider.key,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomTextForm(
                            controller: provider.fullNameController,
                            hintText: 'Nombre completo',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El nombre completo es obligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextForm(
                            controller: provider.usernameController,
                            hintText: 'Usuario',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El usuario es obligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                provider.birthdateController.text =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextForm(
                                controller: provider.birthdateController,
                                hintText: 'Fecha de nacimiento',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La fecha de nacimiento es obligatoria';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                             width: MediaQuery.sizeOf(context).width*0.84,
                            child: DropdownButtonFormField<String>(
                              value: provider.selectedIdType,
                              decoration: const InputDecoration(
                                hintText: 'Tipo de identificación',
                                border: OutlineInputBorder(),
                              ),
                              items: provider.idTypes.map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (value) {
                                provider.selectedIdType = value!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'El tipo de identificación es obligatorio';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextForm(
                            controller: provider.idNumberController,
                            hintText: 'Número de identificación',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El número de identificación es obligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextForm(
                            controller: provider.phoneController,
                            hintText: 'Número telefónico',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El número telefónico es obligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width*0.84,
                            child: DropdownButtonFormField<String>(
                              value: provider.selectedGender,
                              decoration: const InputDecoration(
                                hintText: 'Género',
                                border: OutlineInputBorder(),
                              ),
                              items: provider.genders.map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              onChanged: (value) {
                                provider.selectedGender = value!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'El género es obligatorio';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextForm(
                            controller: provider.emailController,
                            hintText: 'Correo electrónico',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El correo electrónico es obligatorio';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextForm(
                            controller: provider.passwordController,
                            hintText: 'Contraseña',
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'La contraseña es obligatoria';
                              } else if (value.length < 8 && value.length > 8) {
                                return 'La contraseña debe tener al menos 8 a 16 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (provider.key.currentState!.validate()) {
                                provider.registerUser(context);
                              }
                            },
                            child: const Text('Registrar Usuario'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
