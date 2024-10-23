import 'package:flutter/material.dart';
import 'package:ganagov/global/widgets/text_span.dart';
import 'package:ganagov/module/seller/model_seller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DetailViewPage extends StatelessWidget {
  final Sale sale;

  const DetailViewPage({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        centerTitle: true,
        title: CustomTextSpan(
          primary: const Color.fromARGB(255, 54, 54, 54),
          secondary: colorScheme.primary,
          textPrimary: "Detalle de Venta     Gana",
          textSecondary: "Gov",
          sizePrimary: 23,
          sizeSecondary: 23,
        ),
        shape: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 17, 163, 3), width: 5),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 244, 244, 244),
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  sale.fotos[0],
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raza: ${sale.raza}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Precio: \$${sale.precio}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Cantidad: ${sale.cantidad}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Edad: ${sale.edad} años',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Estado: ${sale.estado}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Descripción: ${sale.descripcion}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      'Departamento: ${sale.departamento}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _openWhatsApp(sale.telefono),
                    child: const Text('WhatsApp'),
                  ),
                  ElevatedButton(
                    onPressed: () => _callNumber(sale.telefono),
                    child: const Text('Llamar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openWhatsApp(tel) async {
    String _url = 'https://wa.me/$tel';
    bool whatsappInstalled = await _isWhatsappInstalled();

    if (whatsappInstalled) {
      bool launched = await launch(_url, forceSafariVC: false);
      if (!launched) {}
    } else {
      bool launched = await launch(_url);
      if (!launched) {}
    }
  }

  Future<bool> _isWhatsappInstalled() async {
    bool isInstalled = await canLaunch('whatsapp://');
    return isInstalled;
  }

  _callNumber(tel) async {
    await FlutterPhoneDirectCaller.callNumber(tel);
  }
}
