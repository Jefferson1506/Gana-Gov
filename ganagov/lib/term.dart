import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TerminosYCondicionesPage extends StatelessWidget {
  const TerminosYCondicionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText('Términos y Condiciones'),
        backgroundColor: const Color.fromARGB(255, 165, 217, 24),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 14,
          children: [
            AutoSizeText(
              'TÉRMINOS Y CONDICIONES DE USO DE LA APLICACIÓN MÓVIL "GANAGOV"',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
              '1. INTRODUCCIÓN',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
              'Bienvenido a Ganagov. Al descargar, instalar y utilizar nuestra aplicación móvil, usted acepta cumplir y estar sujeto a los presentes Términos y Condiciones de Uso. Si no está de acuerdo con estos términos, por favor absténgase de usar la aplicación.',
            ),
            AutoSizeText(
              '2. DEFINICIONES',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
                '• Aplicación: Se refiere a la aplicación móvil Ganagov.'),
            AutoSizeText(
                '• Usuario Vendedor: Persona que se registra en la aplicación para publicar ventas de ganado.'),
            AutoSizeText(
                '• Usuario Comprador: Persona que utiliza la aplicación para visualizar publicaciones de venta y contactar a los vendedores.'),
            AutoSizeText(
                '• Datos Personales: Información ingresada por los Usuarios Vendedores al registrarse.'),
            AutoSizeText(
              '3. FUNCIONALIDADES CLAVES DE LA APLICACIÓN',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText('• Visualización de ventas de ganado.'),
            AutoSizeText(
                '• Contacto directo por medio de publicaciones entre vendedores y compradores mediante aplicaciones de terceros, WhatsApp y llamada telefónica.'),
            AutoSizeText('• Registro obligatorio para Usuarios Vendedores.'),
            AutoSizeText(
                '• Acceso libre para Usuarios Compradores sin necesidad de registro.'),
            AutoSizeText(
              '4. REGISTRO DE USUARIOS VENDEDORES',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
                '• Para publicar ventas, los usuarios deben registrarse proporcionando datos personales como nombre completo, número de teléfono y otros datos requeridos.'),
            AutoSizeText(
                '• El usuario es responsable de la veracidad y actualización de la información personal proporcionada en el registro de su cuenta en Ganagov.'),
            AutoSizeText(
              '5. RESPONSABILIDADES DEL USUARIO',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
                '• Los Usuarios Vendedores son responsables del contenido publicado en sus anuncios.'),
            AutoSizeText(
                '• Los Usuarios Compradores son responsables de verificar la autenticidad de la información proporcionada por los vendedores.'),
            AutoSizeText(
                '• Ganagov no interviene en las negociaciones ni en la transacción final entre usuarios.'),
            AutoSizeText(
              '6. PRIVACIDAD Y PROTECCIÓN DE DATOS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
                '• La aplicación recopila y almacena los datos personales de los Usuarios Vendedores con fines de contacto y gestión de sus publicaciones.'),
            AutoSizeText(
                '• La protección de los datos personales y la seguridad de la información almacenada son gestionadas a través de los servicios proporcionados por Firebase.'),
            AutoSizeText(
                '• Firebase cumple con estándares internacionales de seguridad y privacidad, garantizando la protección de los datos almacenados.'),
            AutoSizeText(
                '• No compartimos datos personales con terceros sin el consentimiento explícito del usuario.'),
            AutoSizeText(
              '7. LIMITACIÓN DE RESPONSABILIDAD',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
                '• Ganagov no se hace responsable por fraudes, malentendidos o incumplimientos en las negociaciones entre usuarios.'),
            AutoSizeText(
                '• La aplicación es solo un medio de contacto entre vendedores y compradores.'),
            AutoSizeText(
              '8. MODIFICACIONES A LOS TÉRMINOS Y CONDICIONES',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
                '• Nos reservamos el derecho de modificar estos Términos y Condiciones en cualquier momento.'),
            AutoSizeText(
                '• Los cambios serán notificados a los usuarios a través de la aplicación con al menos 7 días de anticipación.'),
            AutoSizeText(
              '9. CONTACTO',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
                '• Para consultas, dudas o soporte técnico, puede contactarnos a través de los canales habilitados en la aplicación.'),
            AutoSizeText('• Correo: oscarjgrau@gmail.com'),
            AutoSizeText(
              '10. ACEPTACIÓN DE LOS TÉRMINOS',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            AutoSizeText(
                '• Al utilizar Ganagov, usted acepta y comprende estos Términos y Condiciones en su totalidad.'),
            AutoSizeText(
                '• Los usuarios vendedores aceptan estos términos al completar su registro.'),
            AutoSizeText(
              'Fecha de última actualización: [03/01/2025]',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

class TerminosYCondiciones extends StatelessWidget {
  const TerminosYCondiciones({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padding = width * 0.05;

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => TerminosYCondicionesPage())),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              "Al continuar, aceptas nuestros",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
              maxLines: 1,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: "términos y condiciones",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: " de uso y reconoces que entiendes la ",
                  ),
                  TextSpan(
                    text: "política de seguridad",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
