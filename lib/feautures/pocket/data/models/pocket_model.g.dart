// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PocketModelAdapter extends TypeAdapter<PocketModel> {
  @override
  final int typeId = 0;

  @override
  PocketModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PocketModel(
      id: fields[0] as String,
      name: fields[1] as String,
      iconEmoji: fields[2] as String,
      balance: fields[3] as double,
      targetAmount: fields[4] as double,
      allocationPercentage: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PocketModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconEmoji)
      ..writeByte(3)
      ..write(obj.balance)
      ..writeByte(4)
      ..write(obj.targetAmount)
      ..writeByte(5)
      ..write(obj.allocationPercentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PocketModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
