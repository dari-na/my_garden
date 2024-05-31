import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_garden/screens/home.dart';
import 'package:my_garden/service/plant_service.dart';
import 'package:provider/provider.dart';

import 'components/plantlist_provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final plantService = PlantService();
  runApp(
    ChangeNotifierProvider<PlantListProvider>(
      create: (context) => PlantListProvider(),
      child: MyApp(plantService: plantService),
    ),
  );
  //runApp(MyApp(plantService: plantService));
}

class MyApp extends StatelessWidget {
  final PlantService plantService;

  const MyApp({Key? key, required this.plantService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


