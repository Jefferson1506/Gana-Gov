import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String? username;

  @HiveField(1)
  final String? password;

  @HiveField(2)
  final String? role;

  @HiveField(3)
  final String? estado;

  @HiveField(4)
  final String? correo;

  @HiveField(5)
  final String? fecha;

  @HiveField(6)
  final String? idNumber;

  @HiveField(7)
  final String? idType;

  @HiveField(8)
  final String? nombre;

  @HiveField(9)
  final String? sexo;

  @HiveField(10)
  final String? telefono;

  UserModel({
    this.username,
    this.password,
    this.role,
    this.estado,
    this.correo,
    this.fecha,
    this.idNumber,
    this.idType,
    this.nombre,
    this.sexo,
    this.telefono,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      username: data['User'],
      password: data['clave'],
      role: data['rol'],
      estado: data['Estado'],
      correo: data['correo'],
      fecha: data['fecha'],
      idNumber: data['idNumber'],
      idType: data['idType'],
      nombre: data['nombre'],
      sexo: data['sexo'],
      telefono: data['telefono'],
    );
  }
}
