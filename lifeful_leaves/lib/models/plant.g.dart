// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantAdapter extends TypeAdapter<Plant> {
  @override
  final int typeId = 0;

  @override
  Plant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plant()
      ..name = fields[0] as String
      ..spieces = fields[1] as String
      ..room = fields[2] as String
      ..description = fields[3] as String
      ..daysBetweenWaterings = fields[4] as int
      ..picturePath = fields[5] as String
      ..lastWatering = fields[6] as DateTime
      ..nextWatering = fields[7] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Plant obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.spieces)
      ..writeByte(2)
      ..write(obj.room)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.daysBetweenWaterings)
      ..writeByte(5)
      ..write(obj.picturePath)
      ..writeByte(6)
      ..write(obj.lastWatering)
      ..writeByte(7)
      ..write(obj.nextWatering);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
