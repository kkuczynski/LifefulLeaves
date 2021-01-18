// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 1;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings()
      ..useWeatherStation = fields[0] as bool
      ..tmpTemperature = fields[1] as int
      ..tmpHumidity = fields[2] as int
      ..adjustWateringsBasedOnConditions = fields[3] as bool
      ..notificationsTime = fields[4] as TimeOfDay;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.useWeatherStation)
      ..writeByte(1)
      ..write(obj.tmpTemperature)
      ..writeByte(2)
      ..write(obj.tmpHumidity)
      ..writeByte(3)
      ..write(obj.adjustWateringsBasedOnConditions)
      ..writeByte(4)
      ..write(obj.notificationsTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
