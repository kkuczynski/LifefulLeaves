import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifeful_leaves/models/plant.dart';
import 'package:lifeful_leaves/models/plant_with_index.dart';
import 'package:lifeful_leaves/services/database_service.dart';

import 'notification_service.dart';

class WateringService {
  final DatabaseService databaseService;
  final FlutterLocalNotificationsPlugin notifsPlugin;
  final NotificationService notificationService;
  double averageTemperature = 22.0;
  double averageHumidity = 40.0;
  double referenceHumidity = 40.0;
  double referenceTemperature = 22.0;
  double wateringMultiplier;

  WateringService(
      this.databaseService, this.notifsPlugin, this.notificationService) {
    calculateAverageHumidity();
    calculateAverageTemperature();
    calculateWateringMultiplier();
  }

  waterPlant(int plantIndex) async {
    Plant plant = databaseService.getPlantFromDatabase(plantIndex);
    plant.lastWatering = DateTime.now();
    plant.nextWatering = calcNextWatering(plantIndex);
    databaseService.putPlantAtIndex(plantIndex, plant);
    notificationService.scheduleWeeklyNotifications(this, notifsPlugin);
  }

  DateTime calcNextWatering(int plantIndex) {
    var now = new DateTime.now();
    if (databaseService.getSettingsBox().adjustWateringsBasedOnConditions) {
      return now.add(new Duration(
          days: databaseService
                  .getPlantFromDatabase(plantIndex)
                  .daysBetweenWaterings *
              wateringMultiplier.round()));
    } else {
      return now.add(new Duration(
          days: databaseService
              .getPlantFromDatabase(plantIndex)
              .daysBetweenWaterings));
    }
  }

  calculateAverageTemperature() {
    List<double> temperatureList =
        databaseService.getWeeklyConditions().temperature;
    double temperaturesSum = 0.0;
    temperatureList.forEach((element) => temperaturesSum += element);
    this.averageTemperature = temperaturesSum / temperatureList.length;
  }

  calculateAverageHumidity() {
    List<double> humidityList = databaseService.getWeeklyConditions().humidity;
    double humiditiesSum = 0.0;
    humidityList.forEach((element) => humiditiesSum += element);
    this.averageTemperature = humiditiesSum / humidityList.length;
  }

  calculateWateringMultiplier() {
    var now = new DateTime.now();
    wateringMultiplier = 0.8 +
        0.01 * (averageHumidity - referenceHumidity) +
        0.02 * (averageTemperature - referenceTemperature) +
        0.1 * (7 - now.month).abs();
  }

  int getTomorrowToWaterAmount() {
    return getPlantsToWaterTomorrowList().length;
  }

  List<PlantWithIndex> getPlantsToWaterTodayList() {
    List<PlantWithIndex> plantsToWater = [];
    Plant tmpPlant;
    DateTime today = DateTime.now();
    DateTime nextWatering;
    int length = databaseService.getPlantBoxLength();
    for (int i = 0; i < length; i++) {
      tmpPlant = databaseService.getPlantFromDatabase(i);
      if (tmpPlant.nextWatering != null) {
        nextWatering = DateTime.parse(tmpPlant.nextWatering.toIso8601String());
        //print(nextWatering);
        if (nextWatering.isBefore(today.add(Duration(
            hours: 24 - today.hour,
            minutes: 60 - today.minute,
            seconds: 60 - today.second)))) {
          plantsToWater.add(PlantWithIndex(i, tmpPlant));
        }
      }
    }
    return plantsToWater;
  }

  List<PlantWithIndex> getPlantsToWaterTomorrowList() {
    List<PlantWithIndex> plantsToWater = [];
    Plant tmpPlant;
    DateTime today = DateTime.now();
    DateTime nextWatering;
    int length = databaseService.getPlantBoxLength();
    for (int i = 0; i < length; i++) {
      tmpPlant = databaseService.getPlantFromDatabase(i);
      if (tmpPlant.nextWatering != null) {
        nextWatering = DateTime.parse(tmpPlant.nextWatering.toIso8601String());
        //print(nextWatering);
        if (nextWatering.isBefore(today.add(Duration(
            hours: 48 - today.hour,
            minutes: 60 - today.minute,
            seconds: 60 - today.second)))) {
          plantsToWater.add(PlantWithIndex(i, tmpPlant));
        }
      }
    }
    return plantsToWater;
  }

  int getAmountOfPlantsToWaterInXDaysList(int x) {
    List<PlantWithIndex> plantsToWater = [];
    Plant tmpPlant;
    DateTime today = DateTime.now();
    DateTime nextWatering;
    int length = databaseService.getPlantBoxLength();
    for (int i = 0; i < length; i++) {
      tmpPlant = databaseService.getPlantFromDatabase(i);
      if (tmpPlant.nextWatering != null) {
        nextWatering = DateTime.parse(tmpPlant.nextWatering.toIso8601String());
        //print(nextWatering);
        if (nextWatering.isBefore(today.add(Duration(
                days: x,
                hours: 24 - today.hour,
                minutes: 60 - today.minute,
                seconds: 60 - today.second))) &&
            nextWatering.isBefore(today.add(Duration(
                days: x - 1,
                hours: 24 - today.hour,
                minutes: 60 - today.minute,
                seconds: 60 - today.second)))) {
          plantsToWater.add(PlantWithIndex(i, tmpPlant));
        }
      }
    }
    return plantsToWater.length;
  }
}
