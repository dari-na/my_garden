import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/plantlist_provider.dart';
import '../entities/plant.dart';
import 'shared_preferences_service.dart';

class PlantService {
  final sharedPreferencesService = SharedPreferencesService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final plantListProvider = PlantListProvider();


  //PlantService(this.plantListProvider);

  Future<void> addPlant(Plant plant) async {
    final plants = await getPlant();
    plants.add(plant);
    plantListProvider.addPlant(plant);
    final collectionRef = firestore.collection("plants");
    await collectionRef.add(plant.toJson());
    await sharedPreferencesService.savePlant(plants);
  }

  Future<List<Plant>> getPlant() async {
    return await sharedPreferencesService.loadPlants();
  }
}
