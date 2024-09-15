import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/module/login/provider/login_provider.dart';
import 'package:ganagov/widgets/backgraound.dart';
import 'package:ganagov/widgets/img.dart';
import 'package:ganagov/widgets/text_form.dart';
import 'package:ganagov/widgets/text_span.dart';
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
                      controller: provider.userController,
                      hintText: "Correo electrónico",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.people_alt,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu correo / usuario';
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
                        obscureText: provider.obscureText,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.emailAddress,
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
                            prefixIcon: Icon(Icons.lock_clock_sharp,
                                color: colorScheme.secondary),
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
                                fontSize: 15, color: colorScheme.primary),
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
                          onPressed: provider.submit,
                          child: const AutoSizeText(
                            "Ingresar",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                    ),
                    SizedBox(
                      height: size * 0.04,
                    ),
                    InkWell(
                      onTap: () {},
                      child: AutoSizeText.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "A un no tienes cuenta?  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 54, 54, 54),
                              ),
                            ),
                            TextSpan(
                              text: "Registrate",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: size * 0.04,
                    ),
                    TextButton.icon(
                      onPressed: () {},
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
          left: 0,
          right: 0,
          child: CustomTextSpan(
              primary: const Color.fromARGB(255, 54, 54, 54),
              secondary: colorScheme.primary,
              textPrimary: "Gana ",
              textSecondary: "Gov",
              sizePrimary: 20,
              sizeSecondary: 20)),
    ],
  );
}
