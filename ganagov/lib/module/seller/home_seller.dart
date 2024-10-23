import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ganagov/module/seller/detalle.dart';
import 'package:ganagov/module/seller/model_seller.dart';

class PublicViewPage extends StatefulWidget {
  @override
  _PublicViewPageState createState() => _PublicViewPageState();
}

class _PublicViewPageState extends State<PublicViewPage> {
  List<Sale> sales = [];
  List<String> breeds = [];
  String? selectedBreed;
  String? selectedDepartment;
  String? selectedCategory;
  String? selectedSaleType;

  final List<String> categories = ['Lechero', 'De Carne', 'Doble Propósito'];
  final List<String> saleTypes = ['Animal', 'Lote'];

  @override
  void initState() {
    super.initState();
    fetchSales();
    fetchBreeds();
  }

  Future<void> fetchSales() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('ganado').get();
    setState(() {
      sales = snapshot.docs.map((doc) => Sale.fromFirestore(doc)).toList();
    });
  }

  Future<void> fetchBreeds() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Breeds').get();
    setState(() {
      breeds = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  List<Sale> get filteredSales {
    return sales.where((sale) {
      final matchesBreed = selectedBreed == null || sale.raza == selectedBreed;
      final matchesDepartment =
          selectedDepartment == null || sale.departamento == selectedDepartment;
      final matchesCategory =
          selectedCategory == null || sale.categoria == selectedCategory;
      final matchesSaleType =
          selectedSaleType == null || sale.tipoVenta == selectedSaleType;
      return matchesBreed &&
          matchesDepartment &&
          matchesCategory &&
          matchesSaleType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas Disponibles'),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  hint: const Text('Raza'),
                  value: selectedBreed,
                  items: breeds.map((String breed) {
                    return DropdownMenuItem(value: breed, child: Text(breed));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBreed = value;
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: const Text('Departamento'),
                  value: selectedDepartment,
                  items: sales
                      .map((sale) {
                        return DropdownMenuItem(
                            value: sale.departamento,
                            child: Text(sale.departamento));
                      })
                      .toSet()
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDepartment = value;
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: const Text('Categoría'),
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem(
                        value: category, child: Text(category));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: const Text('Tipo de Venta'),
                  value: selectedSaleType,
                  items: saleTypes.map((String saleType) {
                    return DropdownMenuItem(
                        value: saleType, child: Text(saleType));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSaleType = value;
                    });
                  },
                ),
              ],
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
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
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
                        Image.network(
                          sale.fotos[0],
                          fit: BoxFit.cover,
                          height: 100,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Raza: ${sale.raza}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
