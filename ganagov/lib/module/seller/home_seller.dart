import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ganagov/global/widgets/text_span.dart';
import 'package:ganagov/module/seller/detalle.dart';
import 'package:ganagov/module/seller/model_seller.dart';

class SalesView extends StatefulWidget {
  @override
  _SalesViewState createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  String? selectedBreed;
  String? selectedDepartment;
  String? selectedCategory;
  String? selectedSaleType;

  List<Sale> allSales = [];
  List<Sale> filteredSales = [];

  final List<String> _categorias = ['Lechero', 'De Carne', 'Doble Propósito'];
  final List<String> _tiposVenta = ['Animal', 'Lote'];
  final List<String> _departamentos = [];

  @override
  void initState() {
    super.initState();
    fetchSalesData();
  }

  Future<void> fetchSalesData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Ganado').get();
    allSales = querySnapshot.docs.map((doc) {
      return Sale.fromFirestore(doc);
    }).toList();
    filteredSales = allSales;
    setState(() {});
  }

  void filterSales() {
    setState(() {
      filteredSales = allSales.where((sale) {
        return (selectedBreed == null || sale.raza == selectedBreed) &&
            (selectedDepartment == null ||
                sale.departamento == selectedDepartment) &&
            (selectedCategory == null || sale.categoria == selectedCategory) &&
            (selectedSaleType == null || sale.tipoVenta == selectedSaleType);
      }).toList();
    });
  }

  void resetFilters() {
    setState(() {
      selectedBreed = null;
      selectedDepartment = null;
      selectedCategory = null;
      selectedSaleType = null;
      filteredSales = allSales;
    });
  }

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
          textPrimary: "Ventas de Ganado     Gana",
          textSecondary: "Gov",
          sizePrimary: 23,
          sizeSecondary: 23,
        ),
        shape: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 17, 163, 3), width: 5),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: resetFilters,
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                  ),
                  DropdownButton<String>(
                    hint: const Text('Raza'),
                    value: selectedBreed,
                    items: [],
                    onChanged: (value) {
                      setState(() {
                        selectedBreed = value;
                      });
                      filterSales();
                    },
                  ),
                  DropdownButton<String>(
                    hint: const Text('Departamento'),
                    value: selectedDepartment,
                    items: _departamentos.map((String department) {
                      return DropdownMenuItem(
                          value: department, child: Text(department));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDepartment = value;
                      });
                      filterSales();
                    },
                  ),
                  DropdownButton<String>(
                    hint: const Text('Categoría'),
                    value: selectedCategory,
                    items: _categorias.map((String category) {
                      return DropdownMenuItem(
                          value: category, child: Text(category));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                      filterSales();
                    },
                  ),
                  DropdownButton<String>(
                    hint: const Text('Tipo de Venta'),
                    value: selectedSaleType,
                    items: _tiposVenta.map((String saleType) {
                      return DropdownMenuItem(
                          value: saleType, child: Text(saleType));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSaleType = value;
                      });
                      filterSales();
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSales.length,
              itemBuilder: (context, index) {
                final sale = filteredSales[index];
                return SaleCard(
                  sale: sale,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
