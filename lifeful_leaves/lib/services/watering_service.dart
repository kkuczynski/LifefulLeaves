import 'package:lifeful_leaves/models/plant.dart';
import 'package:lifeful_leaves/services/database_service.dart';

class WateringService {
  DatabaseService databaseService;

  double averageTemperature;
  double averageHumidity;
  double referenceHumidity = 40.0;
  double referenceTemperature = 22.0;
  double wateringMultiplier;
  WateringService(this.databaseService) {
    calculateAverageHumidity();
    calculateAverageTemperature();
    calculateWateringMultiplier();
  }

  waterPlant(int plantIndex) {
    Plant plant = databaseService.getPlantFromDatabase(plantIndex);
    plant.lastWatering = DateTime.now();
    plant.nextWatering = calcNextWatering(plantIndex);
    databaseService.putPlantAtIndex(plantIndex, plant);
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
}
