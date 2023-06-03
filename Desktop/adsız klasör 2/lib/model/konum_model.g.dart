// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'konum_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KonumModelAdapter extends TypeAdapter<KonumModel> {
  @override
  final int typeId = 2;

  @override
  KonumModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KonumModel(
      lan: fields[5] as double,
      lat: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, KonumModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(5)
      ..write(obj.lan)
      ..writeByte(6)
      ..write(obj.lat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KonumModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
