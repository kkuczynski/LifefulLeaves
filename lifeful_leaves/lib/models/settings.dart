import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings {
  @HiveField(0)
  bool useWeatherStation = true;
  @HiveField(1)
  int tmpTemperature;
  @HiveField(2)
  int tmpHumidity;
  @HiveField(3)
  bool adjustWateringsBasedOnConditions = true;
  @HiveField(4)
  TimeOfDay notificationsTime;
}
