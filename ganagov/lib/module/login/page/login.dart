import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/module/login/provider/login_provider.dart';
import 'package:ganagov/global/widgets/backgraound.dart';
import 'package:ganagov/global/widgets/img.dart';
import 'package:ganagov/global/widgets/text_form.dart';
import 'package:ganagov/global/widgets/text_span.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context).height;

    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            backgroundAfternoon(context),
            SingleChildScrollView(child:
                Consumer<LoginProvider>(builder: (context, provider, child) {
              return Form(
                key: provider.keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logo(context),
                    CustomTextForm(
                      iconColor: Colors.black,
                      controller: provider.userController,
                      hintText: "Usuario",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.people_alt,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa su usuario';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: provider.passwordController,
                        obscureText: provider.obscureText,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa contraseña';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Contraseña",
                            filled: true,
                            fillColor: const Color.fromARGB(255, 244, 244, 244),
                            suffixIcon: IconButton(
                                onPressed: provider.obscureAlt,
                                icon: provider.obscureText
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined)),
                            prefixIcon: const Icon(Icons.lock_clock_sharp,
                                color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorScheme.tertiary),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorScheme.tertiary),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    SizedBox(
                      height: size * 0.04,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "recover"),
                          child: AutoSizeText(
                            "Olvidaste tu contraseña?",
                            style: TextStyle(
                                fontSize: 16, color: colorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size * 0.04,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: size * 0.08,
                      child: ElevatedButton(
                          onPressed: () => provider.submit(context),
                          child: const AutoSizeText(
                            "Ingresar",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                    ),
                    SizedBox(
                      height: size * 0.04,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, "new_user"),
                      child: CustomTextSpan(
                          primary: const Color.fromARGB(255, 54, 54, 54),
                          secondary: colorScheme.primary,
                          textPrimary: "No tienes cuenta?  ",
                          textSecondary: "Registrate",
                          sizePrimary: 14,
                          sizeSecondary: 14),
                    ),
                    SizedBox(
                      height: size * 0.04,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, "home_seller");
                      },
                      label: AutoSizeText(
                        "Ver Publicaciones",
                        style:
                            TextStyle(fontSize: 15, color: colorScheme.primary),
                      ),
                      icon: const Icon(Icons.play_arrow),
                    ),
                  ],
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}

Widget logo(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final size = MediaQuery.sizeOf(context).height;
  return Stack(
    alignment: Alignment.center,
    children: [
      imgLogo(context, 0.3),
      Positioned(
          top: size * 0.19,
          child: CustomTextSpan(
              primary: const Color.fromARGB(255, 54, 54, 54),
              secondary: colorScheme.primary,
              textPrimary: "Gana",
              textSecondary: "Gov",
              sizePrimary: 18,
              sizeSecondary: 18)),
    ],
  );
}
