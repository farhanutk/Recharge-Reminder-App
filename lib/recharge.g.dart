// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recharge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RechargeAdapter extends TypeAdapter<Recharge> {
  @override
  final int typeId = 0;

  @override
  Recharge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recharge(
      id: fields[0] as int?,
      name: fields[1] as String,
      number: fields[2] as String,
      amount: fields[3] as String,
      date: fields[4] as String,
      info: fields[5] as String,
      operator: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Recharge obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.info)
      ..writeByte(6)
      ..write(obj.operator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RechargeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
