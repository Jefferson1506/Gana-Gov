import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/widgets/backgraound.dart';
import 'package:ganagov/widgets/img.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool a = false;
  @override
  void initState() {
    a = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context).height;
    final formKey = GlobalKey();

    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          background(context),
          SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logo(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Usuario o Correo",
                          filled: true,
                          fillColor: const Color.fromARGB(255, 244, 244, 244),
                          prefixIcon:
                              Icon(Icons.email, color: colorScheme.secondary),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorScheme.tertiary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorScheme.tertiary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  SizedBox(
                    height: size * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      obscureText: true,
                      obscuringCharacter: "*",
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Contraseña",
                          filled: true,
                          fillColor: const Color.fromARGB(255, 244, 244, 244),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.visibility_off_outlined)),
                          prefixIcon: Icon(Icons.lock_clock_sharp,
                              color: colorScheme.secondary),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorScheme.tertiary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorScheme.tertiary),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                  SizedBox(
                    height: size * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Alinea los elementos
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                side: BorderSide(color: Colors.black, width: 2),
                                checkColor: Colors.white,
                                activeColor: colorScheme.secondary,
                                value: a,
                                onChanged: (onche) {
                                  setState(() {
                                    a = !a;
                                  });
                                }),
                            SizedBox(
                                width:
                                    8), // Espacio entre el checkbox y el texto
                            AutoSizeText("Recordar",
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: AutoSizeText(
                            "Olvidaste tu contraseña?",
                            style: TextStyle(
                                fontSize: 15, color: colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size * 0.04,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: size * 0.09,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {},
                        child: AutoSizeText(
                          "Ingresar",
                          style: TextStyle(color: Colors.white),
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
                          TextSpan(
                            text: "A un no tienes cuenta?  ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: const Color.fromARGB(255, 54, 54, 54),
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
                    icon: Icon(Icons.play_arrow),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Gana ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.03,
                  color: const Color.fromARGB(255, 54, 54, 54),
                ),
              ),
              TextSpan(
                text: "Gov",
                style: TextStyle(
                  fontSize: size * 0.03,
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
    ],
  );
}

/*
   SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    height: size * 0.2,
                    child: InkWell(
                        onTap: () {},
                        child: Card(
                            color: Colors.black,
                            child: Center(
                              child: AutoSizeText(
                                textAlign: TextAlign.center,
                                "Ingresar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ))),
                  )*/