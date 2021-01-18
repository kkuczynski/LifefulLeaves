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
}
