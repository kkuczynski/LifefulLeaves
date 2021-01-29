import 'package:hive/hive.dart';
import 'package:lifeful_leaves/models/plant.dart';
import 'package:lifeful_leaves/models/settings.dart';
import 'package:lifeful_leaves/models/weekly_conditions.dart';

class DatabaseService {
  Box<Plant> plantBox;
  Box<Settings> settingsBox;
  Box<WeeklyConditions> weeklyConditionsBox;
  DatabaseService(this.plantBox, this.settingsBox, this.weeklyConditionsBox);
  addPlantToDatabase(Plant plant) {
    plantBox.add(plant);
  }

  putPlantAtIndex(int index, Plant plant) {
    plantBox.putAt(index, plant);
  }

  Plant getPlantFromDatabase(int index) {
    return plantBox.getAt(index);
  }

  deletePlantAtIndex(int index) {
    plantBox.deleteAt(index);
  }

  int getPlantBoxLength() {
    return plantBox.length;
  }

  Settings getSettingsBox() {
    return settingsBox.getAt(0);
  }

  initDefaultSettings() {
    if (settingsBox.length == 0) {
      Settings settings = Settings();
      settings.adjustWateringsBasedOnConditions = true;
      settings.notificationsTimeHour = 17;
      settings.notificationsTimeMinute = 0;
      settings.tmpHumidity = 40.0;
      settings.tmpTemperature = 22.0;
      settings.useWeatherStation = true;
      settings.weatherStationAddress = 'http://192.168.8.105/';
      settingsBox.add(settings);
    }
  }

  fillWeeklyConditionsWithDefaultValues() {
    if (weeklyConditionsBox.length == 0) {
      WeeklyConditions weeklyConditions = WeeklyConditions();
      double humidity = settingsBox.getAt(0).tmpHumidity;
      double temperature = settingsBox.getAt(0).tmpTemperature;
      weeklyConditions.humidity = new List(7);
      weeklyConditions.temperature = new List(7);
      for (int i = 0; i < 7; i++) {
        weeklyConditions.humidity[i] = humidity;
        weeklyConditions.temperature[i] = temperature;
      }
      weeklyConditions.lastUpdate = 0;
      weeklyConditionsBox.add(weeklyConditions);
    }
  }

  WeeklyConditions getWeeklyConditions() {
    return weeklyConditionsBox.getAt(0);
  }

  addWeeklyCondition(double humidity, double temperature) {
    getWeeklyConditions().humidity.removeAt(0);
    getWeeklyConditions().humidity.add(humidity);
    getWeeklyConditions().temperature.removeAt(0);
    getWeeklyConditions().temperature.add(temperature);
  }

  saveSettings(Settings settings) {
    settingsBox.putAt(0, settings);
  }
}
