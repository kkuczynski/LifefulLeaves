// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_conditions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyConditionsAdapter extends TypeAdapter<WeeklyConditions> {
  @override
  final int typeId = 2;

  @override
  WeeklyConditions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyConditions()
      ..temperature = (fields[0] as List)?.cast<double>()
      ..humidity = (fields[1] as List)?.cast<double>()
      ..lastUpdate = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, WeeklyConditions obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.temperature)
      ..writeByte(1)
      ..write(obj.humidity)
      ..writeByte(2)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyConditionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
