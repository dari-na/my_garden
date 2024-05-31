import 'package:flutter/cupertino.dart';

import '../entities/plant.dart';

class PlantListProvider extends ChangeNotifier {
  List<Plant> plants = [];

  void addPlant(Plant plant) {
    plants.add(plant);
    notifyListeners(); // Notify listeners about the change
  }

  void addPlants(List<Plant> newPlants) {
    plants.addAll(newPlants);
    notifyListeners();
  }

  void setPlants(List<Plant> newPlants) {
    plants = newPlants;
    notifyListeners();
  }

  List<Plant> get allPlants => plants;



}