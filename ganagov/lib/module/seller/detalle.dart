import 'package:flutter/material.dart';
import 'package:ganagov/module/seller/model_seller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailViewPage extends StatelessWidget {
  final Sale sale;

  const DetailViewPage({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Venta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                sale.fotos[0],
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              const SizedBox(height: 10),
              Text(
                'Raza: ${sale.raza}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text('Precio: \$${sale.precio}'),
              Text('Cantidad: ${sale.cantidad}'),
              Text('Edad: ${sale.edad} años'),
              Text('Estado: ${sale.estado}'),
              Text('Descripción: ${sale.descripcion}'),
              Text('Departamento: ${sale.departamento}'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _launchWhatsApp(sale.telefono),
                    child: const Text('WhatsApp'),
                  ),
                  ElevatedButton(
                    onPressed: () => _launchDial(sale.telefono),
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

  void _launchWhatsApp(String phoneNumber) async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchDial(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
