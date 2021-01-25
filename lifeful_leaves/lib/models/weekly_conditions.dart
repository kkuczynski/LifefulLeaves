import 'package:hive/hive.dart';
part 'weekly_conditions.g.dart';

@HiveType(typeId: 2)
class WeeklyConditions {
  @HiveField(0)
  List<double> temperature;
  @HiveField(1)
  List<double> humidity;
  @HiveField(2)
  int lastUpdate;
}
