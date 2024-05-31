import 'package:flutter/material.dart';
import 'package:my_garden/screens/plant_details.dart';

import '../entities/plant.dart';

class PlantList extends StatelessWidget {
  final List<Plant> plants;

  const PlantList({super.key, required this.plants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plants.length,
      itemBuilder: (context, index) {
        return Container( decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff82A596)),
          borderRadius: BorderRadius.circular(10.0),
        ),
          child: ListTile(
            title: Text(plants[index].name),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantDetails(plant: plants[index]),
              ),
            ),
          ),
        );
      },
    );
  }
}
