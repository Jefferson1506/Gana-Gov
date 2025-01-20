import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ganagov/global/widgets/loanding.dart';
import 'package:ganagov/global/widgets/notify_dialog.dart';
import 'package:ganagov/global/widgets/text_span.dart';
import 'package:ganagov/module/seller/card_seller.dart';
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
  List<String> _razas = [];
  final List<String> _categorias = ['Lechero', 'De Carne', 'Doble Propósito'];
  final List<String> _tiposVenta = ['Animal', 'Lote'];
  final List<String> _departamentos = [
    'Amazonas',
    'Antioquia',
    'Arauca',
    'Atlántico',
    'Bolívar',
    'Boyacá',
    'Caldas',
    'Caquetá',
    'Casanare',
    'Cauca',
    'Cesar',
    'Chocó',
    'Córdoba',
    'Cundinamarca',
    'Guainía',
    'Guaviare',
    'Huila',
    'La Guajira',
    'Magdalena',
    'Meta',
    'Nariño',
    'Norte de Santander',
    'Putumayo',
    'Quindío',
    'Risaralda',
    'San Andrés y Providencia',
    'Santander',
    'Sucre',
    'Tolima',
    'Valle del Cauca',
    'Vaupés',
    'Vichada',
  ];

  @override
  void initState() {
    super.initState();
    _fetchRazas();
    fetchSalesData();
  }

  Future<void> _fetchRazas() async {
    try {
      QuerySnapshot breedsSnapshot =
          await FirebaseFirestore.instance.collection('Breeds').get();
      setState(() {
        _razas =
            breedsSnapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      NotifyDialog.showErrorDialog(context, "Error al cargar las razas: $e");
    }
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

   resetFilters() {
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    items: _razas.map((raza) {
                      return DropdownMenuItem(
                        value: raza,
                        child: Text(raza),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBreed = value;
                      });
                      filterSales();
                    },
                  ),
                  const SizedBox(
                    width: 10,
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
                  const SizedBox(
                    width: 10,
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
                  const SizedBox(
                    width: 10,
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
                return filteredSales.isEmpty || filteredSales == null
                    ? const Center(
                        child: AutoSizeText('No se encontraron elementos'),
                      )
                    : SaleCard(
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
