// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      username: fields[0] as String?,
      password: fields[1] as String?,
      role: fields[2] as String?,
      estado: fields[3] as String?,
      correo: fields[4] as String?,
      fecha: fields[5] as String?,
      idNumber: fields[6] as String?,
      idType: fields[7] as String?,
      nombre: fields[8] as String?,
      sexo: fields[9] as String?,
      telefono: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.estado)
      ..writeByte(4)
      ..write(obj.correo)
      ..writeByte(5)
      ..write(obj.fecha)
      ..writeByte(6)
      ..write(obj.idNumber)
      ..writeByte(7)
      ..write(obj.idType)
      ..writeByte(8)
      ..write(obj.nombre)
      ..writeByte(9)
      ..write(obj.sexo)
      ..writeByte(10)
      ..write(obj.telefono);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
