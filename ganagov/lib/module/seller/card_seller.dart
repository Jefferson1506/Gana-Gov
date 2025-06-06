import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ganagov/module/buyer/page/list_sell.dart';
import 'package:ganagov/module/seller/detalle.dart';
import 'package:ganagov/module/seller/model_seller.dart';
import 'package:intl/intl.dart';

class SaleCard extends StatelessWidget {
  final Sale sale;

  const SaleCard({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 250, 255, 220),
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
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(),
                _buildTitle(),
                _buildDetails(),
                _buildIcons(),
                _buildNegotiableInfo(),
                Center(
                  child: buildTextIconRow(
                    icon: Icons.tag_outlined,
                    text: 'Sexo - ${sale.sexo}',
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: buildTextIconRow(
                    icon: Icons.tag_outlined,
                    text: 'Vacunas al día - ${boolToYesNo(sale.vacuna)}',
                    color: sale.vacuna == true ? Colors.green : Colors.red,
                  ),
                ),
                Center(
                  child: buildTextIconRow(
                    icon: Icons.price_change,
                    text: formatCurrency(double.tryParse(sale.precio) ?? 0),
                    color: Colors.grey,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month,
                      color: Colors.black, size: 16),
                  label: AutoSizeText(
                    'Fecha de publicacion: ${dateTime(sale.fecha)}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
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
              maxLines: 16,
              '${sale.raza} ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            )),
        TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on, color: Colors.black, size: 16),
            label: AutoSizeText(
              maxLines: 16,
              '${sale.departamento} ',
              style: const TextStyle(
                color: Colors.grey,
              ),
            )),
        TextButton.icon(
            onPressed: () {},
            icon:
                const Icon(Icons.location_city, color: Colors.black, size: 16),
            label: AutoSizeText(
              maxFontSize: 16,
              '${sale.municipio} ',
              style: const TextStyle(
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
            icon: const Icon(Icons.handshake_outlined,
                color: Colors.black, size: 16),
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
}

String formatCurrency(double amount) {
  final formatter = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 0,
  );
  return formatter.format(amount);
}

String dateTime(String date) {
  final value = DateTime.parse(date);
  final form = DateFormat.yMMMEd('es');

  return form.format(value).toString();
}
