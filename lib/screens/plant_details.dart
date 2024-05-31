import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entities/plant.dart';

class PlantDetails extends StatelessWidget {
  final Plant plant;

  const PlantDetails({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
        backgroundColor: Color(0xff82A596) ,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Variety:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(width: 10.0),
                Text(
                  '${plant.variety ?? "N/A"}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'Source:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(width: 10.0),
                Text(
                  '${plant.source ?? "N/A"}',
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'Planted Date:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(width: 10.0),
                Text(
                  '${plant.plantedDate?.toString() ?? "N/A"}',
                ),
              ],
            ),
            // Add an image section here if desired
          ],
        ),
      ),
    );
  }
}