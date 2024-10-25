import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ganagov/global/user_model.dart';
import 'package:ganagov/global/widgets/text_span.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MySalesPage extends StatefulWidget {
  @override
  _MySalesPageState createState() => _MySalesPageState();
}

class _MySalesPageState extends State<MySalesPage> {
  final _userBox = Hive.box<UserModel>('users');
  String _userId = '';
  @override
  void initState() {
    final _userModel = _userBox.getAt(0);
    _userId = _userModel!.idNumber.toString();
    super.initState();
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
          textPrimary: "Mis Publicaciones    Gana",
          textSecondary: "Gov",
          sizePrimary: 23,
          sizeSecondary: 23,
        ),
        shape: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 192, 255, 114), width: 5),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Ganado')
            .where('idNumber', isEqualTo: _userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar las ventas.'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tienes ventas registradas.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final venta = snapshot.data!.docs[index];
              return Card(
                color: const Color.fromARGB(255, 255, 254, 207),
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fecha: ${venta['fecha']}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      // ignore: prefer_interpolation_to_compose_strings
                      Text('Sexo:  ' + venta['sexo'],
                          style: const TextStyle(fontSize: 16)),
                      Text('Cantidad: ${venta['cantidad']}',
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                      Text('Categoría: ${venta['categoria']}',
                          style: const TextStyle(fontSize: 16)),
                      Text('Departamento: ${venta['departamento']}',
                          style: const TextStyle(fontSize: 16)),
                      Text('Municipio: ${venta['municipio'] ?? ''}',
                          style: const TextStyle(fontSize: 16)),
                      Text('Edad: ${venta['edad']}',
                          style: const TextStyle(fontSize: 16)),
                      Text('Peso: ${venta['peso']}',
                          style: const TextStyle(fontSize: 16)),
                      Text('Precio: ${venta['precio']}',
                          style: const TextStyle(fontSize: 16)),
                      Text('Descripción: ${venta['descripcion']}',
                          style: const TextStyle(fontSize: 16)),
                      Text('Estado: ${venta['estado']}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: venta['estado'] == 'En Venta'
                                  ? Colors.orange
                                  : venta['estado'] == 'Cancelado'
                                      ? Colors.red
                                      : Colors.green)),
                      const SizedBox(height: 10),
                      _buildEstadoDropdown(venta)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEstadoDropdown(DocumentSnapshot venta) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Cambiar estado:', style: TextStyle(fontSize: 16)),
        DropdownButton<String>(
          value: venta['estado'],
          items: ['En Venta', 'Vendido', 'Cancelado']
              .map((String estado) => DropdownMenuItem<String>(
                    value: estado,
                    child: Text(estado),
                  ))
              .toList(),
          onChanged: (newEstado) {
            _updateEstado(venta.id, newEstado!);
          },
        ),
      ],
    );
  }

  Future<void> _updateEstado(String documentId, String newEstado) async {
    try {
      await FirebaseFirestore.instance
          .collection('Ganado')
          .doc(documentId)
          .update({'estado': newEstado});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Estado actualizado a $newEstado')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el estado')),
      );
    }
  }
}
