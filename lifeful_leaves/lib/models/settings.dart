import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings {
  @HiveField(0)
  bool useWeatherStation;
  @HiveField(1)
  double tmpTemperature;
  @HiveField(2)
  double tmpHumidity;
  @HiveField(3)
  bool adjustWateringsBasedOnConditions;
  @HiveField(4)
  int notificationsTimeHour;
  @HiveField(5)
  int notificationsTimeMinute;
  @HiveField(6)
  String weatherStationAddress;
}
