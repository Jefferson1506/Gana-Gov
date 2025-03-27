import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsPage extends StatelessWidget {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference salesCollection =
      FirebaseFirestore.instance.collection('Ganado');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: usersCollection.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return _crearTarjeta('Número Total De Usuarios',
                    '${snapshot.data?.docs.length}');
              },
            ),
            FutureBuilder<QuerySnapshot>(
              future: salesCollection.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return _crearTarjeta(
                    'Número Total De Publicaciones', '${snapshot.data?.docs.length}');
              },
            ),
            _crearGraficoVentas(),
            _crearGraficoTiposVentas(),
            _crearGraficoPromedioPrecio(),
            _crearGraficoRazasMasVendidas(),
            _crearGraficoVentasPorDepartamento(),
          ],
        ),
      ),
    );
  }

  Widget _crearTarjeta(String titulo, String subtitulo) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text(titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitulo, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _crearGraficoVentas() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<QuerySnapshot>(
        future: salesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          int totalVentas = snapshot.data!.docs.length;

          return SfCartesianChart(
            title: const ChartTitle(
                text: 'Total De Publicaciones',
                textStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            primaryXAxis: const CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<dynamic, String>(
                dataSource: [
                  {'category': 'Total : $totalVentas', 'value': totalVentas}
                ],
                xValueMapper: (data, _) => data['category'],
                yValueMapper: (data, _) => data['value'],
                name: 'Ventas',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _crearGraficoTiposVentas() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<QuerySnapshot>(
        future: salesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          Map<String, int> tiposVentas = {};
          for (var doc in snapshot.data!.docs) {
            String tipo = doc['tipoVenta'];
            tiposVentas[tipo] = (tiposVentas[tipo] ?? 0) + 1;
          }

          return SfCircularChart(
            palette: const [
              Color.fromARGB(255, 17, 163, 3),
              Color.fromARGB(255, 249, 188, 99),
            ],
            title: const ChartTitle(
                text: 'Tipos de Ventas',
                textStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            legend: const Legend(isVisible: true),
            series: <CircularSeries>[
              PieSeries<MapEntry<String, int>, String>(
                dataSource: tiposVentas.entries.toList(),
                xValueMapper: (MapEntry<String, int> data, _) => data.key,
                yValueMapper: (MapEntry<String, int> data, _) => data.value,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _crearGraficoPromedioPrecio() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<QuerySnapshot>(
        future: salesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          double totalPrecio = 0;
          int conteoVentas = 0;

          for (var doc in snapshot.data!.docs) {
            double precio = double.parse(doc['precio']);
            totalPrecio += precio;
            conteoVentas++;
          }

          double precioPromedio =
              conteoVentas > 0 ? totalPrecio / conteoVentas : 0;

          final List<Color> chartColors = [
            Colors.indigo,
            Colors.purple,
            Colors.yellow,
            Colors.blue,
            Colors.red,
            Colors.green,
            Colors.orange,
            Colors.pink,
            Colors.cyan,
            Colors.teal,
          ];

          return SfCartesianChart(
            title: const ChartTitle(
              text: 'Precio Promedio De Publicaciones',
              textStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
            primaryXAxis: const CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<dynamic, String>(
                dataSource: [
                  {'category': 'Precio Promedio', 'value': precioPromedio}
                ],
                xValueMapper: (data, _) => data['category'],
                yValueMapper: (data, _) => data['value'],
                name: 'Precio Promedio',
                pointColorMapper: (data, index) =>
                    chartColors[index],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _crearGraficoRazasMasVendidas() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<QuerySnapshot>(
        future: salesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          Map<String, int> razasVendidas = {};
          for (var doc in snapshot.data!.docs) {
            String raza = doc['raza'];
            razasVendidas[raza] = (razasVendidas[raza] ?? 0) + 1;
          }

          final palette = [
            Color(0xFFFFD1DC),
            Color(0xFFFFE4B5),
            Color(0xFFB39DDB),
            Color(0xFFA7C7E7),
            Color(0xFFFAE7B5),
            Color(0xFFC1E1C1),
            Color(0xFFFFCCCB),
            Color(0xFFD8BFD8),
            Color(0xFFF4A460),
            Color(0xFF98FB98),
          ];
          return SfCartesianChart(
            title: const ChartTitle(
                text: 'Razas Más Publicadas',
                textStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            primaryXAxis: const CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<MapEntry<String, int>, String>(
                dataSource: razasVendidas.entries.toList(),
                xValueMapper: (MapEntry<String, int> data, _) => data.key,
                yValueMapper: (MapEntry<String, int> data, _) => data.value,
                name: 'Ventas',
                pointColorMapper: (data, index) =>
                    palette[index],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _crearGraficoVentasPorDepartamento() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<QuerySnapshot>(
        future: salesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          Map<String, int> ventasPorDepartamento = {};
          for (var doc in snapshot.data!.docs) {
            String departamento = doc['departamento'];
            ventasPorDepartamento[departamento] =
                (ventasPorDepartamento[departamento] ?? 0) + 1;
          }

          final palette =
          [
            Color(0xFFFF073A),
            Color(0xFF00FF00),
            Color(0xFF1E90FF),
            Color(0xFFFFFF00),
            Color(0xFFFF1493),
            Color(0xFF8A2BE2),
            Color(0xFF00FFFF),
            Color(0xFFFFA500),
            Color(0xFFADFF2F),
          ];

          return SfCartesianChart(
            title: const ChartTitle(
                text: 'Publicaciones por Departamento',
                textStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            primaryXAxis: const CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<MapEntry<String, int>, String>(
                dataSource: ventasPorDepartamento.entries.toList(),
                xValueMapper: (MapEntry<String, int> data, _) => data.key,
                yValueMapper: (MapEntry<String, int> data, _) => data.value,
                name: 'Ventas',
                pointColorMapper: (data, index) =>
                    palette[index],
              ),
            ],
          );
        },
      ),
    );
  }
}
