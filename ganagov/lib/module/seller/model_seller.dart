import 'package:cloud_firestore/cloud_firestore.dart';


class Sale {
  final String id;
  final String cantidad;
  final String categoria;
  final String departamento;
  final String descripcion;
  final String edad;
  final String estado;
  final String fecha;
  final List<String> fotos;
  final String idNumber;
  final bool negociable;
  final String peso;
  final String precio;
  final String raza;
  final String telefono;
  final String tipoVenta;

  Sale({
    required this.id,
    required this.cantidad,
    required this.categoria,
    required this.departamento,
    required this.descripcion,
    required this.edad,
    required this.estado,
    required this.fecha,
    required this.fotos,
    required this.idNumber,
    required this.negociable,
    required this.peso,
    required this.precio,
    required this.raza,
    required this.telefono,
    required this.tipoVenta,
  });

  factory Sale.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Sale(
      id: doc.id,
      cantidad: data['cantidad'] ?? '',
      categoria: data['categoria'] ?? '',
      departamento: data['departamento'] ?? '',
      descripcion: data['descripcion'] ?? '',
      edad: data['edad'] ?? '',
      estado: data['estado'] ?? '',
      fecha: data['fecha'] ?? '',
      fotos: List<String>.from(data['fotos'] ?? []),
      idNumber: data['idNumber'] ?? '',
      negociable: data['negociable'] ?? false,
      peso: data['peso'] ?? '',
      precio: data['precio'] ?? '',
      raza: data['raza'] ?? '',
      telefono: data['telefono'] ?? '',
      tipoVenta: data['tipoVenta'] ?? '',
    );
  }
}
