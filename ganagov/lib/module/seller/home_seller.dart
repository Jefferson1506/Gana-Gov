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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredSales.length,
              itemBuilder: (context, index) {
                final sale = filteredSales[index];
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.network(
                            sale.fotos.isNotEmpty ? sale.fotos[0] : '',
                            fit: BoxFit.cover,
                            height: 100,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Raza: ${sale.raza}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Precio: \$${sale.precio}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Tipo: ${sale.tipoVenta}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Teléfono: ${sale.telefono}'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
