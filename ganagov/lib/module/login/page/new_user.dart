import 'package:flutter/material.dart';
import 'package:ganagov/module/login/provider/new_user_provider.dart';
import 'package:ganagov/widgets/backgraound.dart';
import 'package:ganagov/widgets/text.dart';
import 'package:ganagov/widgets/text_form.dart';
import 'package:ganagov/widgets/text_span.dart';
import 'package:provider/provider.dart';

class NewUser extends StatelessWidget {
  const NewUser({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return ChangeNotifierProvider(
        create: (context) => NewUserProvider(),
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
                SizedBox(
                  width: width * 0.03,
                ),
              ],
            ),
            body: Stack(alignment: AlignmentDirectional.topCenter, children: [
              backgroundAfternoon(context),
              SingleChildScrollView(child: Consumer<NewUserProvider>(
                  builder: (context, provider, child) {
                return Form(
                  key: provider.key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Registrate Aqui",
                          colorText: colorScheme.primary,
                          sizeText: 22,
                          bold: true,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          height: height * 0.05,
                          child: CustomTextForm(
                            controller: provider.name,
                            hintText: "Nombre completo",
                            keyboardType: TextInputType.text,
                            sizeText: 12,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa su nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                         SizedBox(
                          height: height * 0.01,
                        ),
                        CustomTextForm(
                          controller: provider.user,
                          hintText: "Usuario",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa su usuario';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }))
            ])));
  }
}
