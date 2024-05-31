import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../entities/plant.dart';

class SharedPreferencesService {
  static const String _plantsKey = 'plants';

  Future<void> savePlant(List<Plant> plants) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final plantStrings = plants.map((plant) => jsonEncode(plant)).toList();
    prefs.setStringList('plants', plantStrings);
  }

  Future<List<Plant>> loadPlants() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedPlants = prefs.getStringList(_plantsKey) ?? [];

    // Filter out elements that fail Plant.fromJson decoding
    final decodedPlants = encodedPlants.whereType<String>()
        .map((plant) => Plant.fromJson(jsonDecode(plant)))
        .toList();

    return decodedPlants;
  }
}
