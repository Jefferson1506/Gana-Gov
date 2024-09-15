import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/module/login/provider/recover_provaider.dart';
import 'package:ganagov/module/login/widgets/text_form.dart';
import 'package:ganagov/module/login/widgets/text_span.dart';
import 'package:provider/provider.dart';

class RecoverPassword extends StatelessWidget {
  const RecoverPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return ChangeNotifierProvider(
      create: (context) => RecoverProvaider(),
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: height * 0.1,
            shape: UnderlineInputBorder(
              borderSide: BorderSide(color: colorScheme.secondary, width: 5),
            ),
            actions: [
              CustomTextSpan(
                primary: const Color.fromARGB(255, 54, 54, 54),
                secondary: colorScheme.primary,
                textPrimary: "Gana",
                textSecondary: "Gov",
                sizePrimary: 35,
                sizeSecondary: 35,
              ),
              SizedBox(
                width: width * 0.03,
              ),
            ],
          ),
          body: Consumer<RecoverProvaider>(builder: (context, provider, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: provider.visibilyUser,
                    child: Form(
                      key: provider.key1,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: width * 0.8,
                        height: height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            AutoSizeText(
                              'Recuperar Contraseña',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: height * 0.03),
                            AutoSizeText(
                              'Escribe tu usuario para formatear tu contraseña.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: height * 0.03),
                            CustomTextForm(
                              controller: provider.email,
                              hintText: "Usuario :",
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor el campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: height * 0.04),
                            ElevatedButton(
                              onPressed: () => provider.visibilityWidget(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const AutoSizeText(
                                'Recuperar contraseña',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //CONTRASEÑA
                  Visibility(
                    visible: provider.visibilyPassword,
                    child: Form(
                      key: provider.key2,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: width * 0.8,
                        height: height * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            AutoSizeText(
                              'Nueva contraseña',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: height * 0.03),
                            AutoSizeText(
                              'Escribe su nueva contraseña, Min 4 - Max 8',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: height * 0.06),
                            CustomTextForm(
                              isPassword: true,
                              controller: provider.newPassword1,
                              hintText: "Contraseña :",
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor el campo es obligatorio';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: height * 0.03),
                            CustomTextForm(
                              isPassword: true,
                              controller: provider.newPassword2,
                              hintText: "Verificar Contraseña :",
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor el campo es obligatorio';
                                } else {
                                  if (provider.newPassword1.text != value) {
                                    return 'Contraseñas diferentes';
                                  }
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: height * 0.06),
                            ElevatedButton(
                              onPressed: () => provider.visibilityWidget(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const AutoSizeText(
                                'Actualizar contraseña',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
