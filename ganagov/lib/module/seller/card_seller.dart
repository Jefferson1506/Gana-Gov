
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/module/seller/detalle.dart';
import 'package:ganagov/module/seller/model_seller.dart';

class SaleCard extends StatelessWidget {
  final Sale sale;

  const SaleCard({Key? key, required this.sale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailViewPage(sale: sale),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(),
                const SizedBox(height: 10),
                _buildTitle(),
                const SizedBox(height: 5),
                _buildDetails(),
                const SizedBox(height: 5),
                _buildIcons(),
                const SizedBox(height: 5),
                _buildNegotiableInfo(),
                const SizedBox(height: 10),
                _buildDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        sale.fotos.isNotEmpty ? sale.fotos[0] : '',
        fit: BoxFit.cover,
        height: 250,
        width: double.infinity,
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
            onPressed: () {},
            label: AutoSizeText(
              '${sale.raza} ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
            )),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on, color: Colors.black, size: 16),
            label: AutoSizeText(
              '${sale.departamento} ',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            )),
        TextButton.icon(
            onPressed: () {},
            icon:
                const Icon(Icons.location_city, color: Colors.black, size: 16),
            label: AutoSizeText(
              '${sale.municipio} ',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            )),
      ],
    );
  }

  Widget _buildDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.confirmation_number_outlined,
                color: Colors.black, size: 16),
            label: AutoSizeText(
              'Cantidad: ${sale.cantidad}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            )),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.monitor_weight_outlined,
                color: Colors.black, size: 16),
            label: AutoSizeText(
              '${sale.peso} kg',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            )),
      ],
    );
  }

  Widget _buildIcons() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.sell, color: Colors.black, size: 16),
              label: AutoSizeText(
                'Venta: ${sale.tipoVenta}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              )),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calendar_today,
                  color: Colors.black, size: 16),
              label: AutoSizeText(
                'Meses: ${sale.edad}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              )),
        ]);
  }

  Widget _buildNegotiableInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
            onPressed: () {},
            label: AutoSizeText(
              sale.estado,
              style: TextStyle(
                  fontSize: 15,
                  color: sale.estado == 'En Venta'
                      ? Colors.orange
                      : sale.estado == 'Cancelado'
                          ? Colors.red
                          : Colors.green),
            )),
        TextButton.icon(
            onPressed: () {},
            icon:
                const Icon(Icons.handshake_outlined, color: Colors.black, size: 16),
            label: AutoSizeText(
              sale.negociable ? 'Si Negociable' : 'No Negociable',
              style: TextStyle(
                fontSize: 15,
                color: sale.negociable ? Colors.green : Colors.red,
              ),
            )),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            sale.descripcion,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
