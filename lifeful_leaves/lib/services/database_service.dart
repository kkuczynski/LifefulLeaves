import 'package:hive/hive.dart';
import 'package:lifeful_leaves/models/plant.dart';
import 'package:lifeful_leaves/models/settings.dart';

class DatabaseService {
  Box<Plant> plantBox;
  Box<Settings> settingsBox;
  DatabaseService(this.plantBox, this.settingsBox);
  addPlantToDatabase(Plant plant) {
    plantBox.add(plant);
  }

  putPlantAtIndex(int index, Plant plant) {
    plantBox.putAt(index, plant);
  }

  Plant getPlantFromDatabase(int index) {
    return plantBox.getAt(index);
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
      settings.tmpTemperature = 23.0;
      settings.useWeatherStation = true;
      settings.weatherStationAddress = 'http://192.168.8.105/';
      settingsBox.add(settings);
    }
  }

  saveSettings(Settings settings) {
    settingsBox.putAt(0, settings);
  }
}
