import 'package:hive/hive.dart';
part 'plant.g.dart';

@HiveType(typeId: 0)
class Plant extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String spieces;
  @HiveField(2)
  String room;
  @HiveField(3)
  String description;
  @HiveField(4)
  int daysBetweenWaterings;
  @HiveField(5)
  String picturePath;
  @HiveField(6)
  DateTime lastWatering;
  @HiveField(7)
  DateTime nextWatering;
}
