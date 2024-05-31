import 'package:flutter/material.dart';
import 'package:my_garden/screens/home.dart';
import 'package:provider/provider.dart';

import '../components/plantlist_provider.dart';
import '../entities/plant.dart';
import '../service/plant_service.dart';
import '../screens/home.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({super.key});
  //final Function(List<Plant>) onPlantAdded;

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  String? _variety;
  String? _source;
  final PlantService _plantService = PlantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Plant name', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'poppins'),),
            const SizedBox(height: 10.0,),
            Container(
              padding: const EdgeInsets.only(left: 4.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Strawberry'),
              ),
            ),
          const SizedBox(height: 20.0,),
          const Text('Variety', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'poppins'),),
          const SizedBox(height: 10.0,),
          Container(
            padding: const EdgeInsets.only(left: 4.0),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12.0),
            ),
            // make into dropdown menu
            child: TextField(
              onChanged: (value) => _variety = value,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Fruit'),
            ),
          ),
              const SizedBox(height: 20.0,),
              const Text('Source', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'poppins'),),
              const SizedBox(height: 10.0,),
              Container(
                padding: const EdgeInsets.only(left: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                // make into dropdown menu
                child: TextField(
                  onChanged: (value) => _source = value,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Local plant shop'),
                ),
              ),
              const SizedBox(height: 30.0,),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final name = _nameController.text.trim();
                  final variety = _variety;
                  final source = _source;
        
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(style:TextStyle(color: Colors.white),'Please enter a plant name'),
                      ),
                    );
                    return ;
                  } else {
                    final plant = Plant(
                        name: name, variety: variety, source: source);
                    await _plantService.addPlant(plant);

                    if (!mounted) return;

                    _nameController.clear();
                    _variety = null;
                    _source = null;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Plant added successfully',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF38604F),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  child: const Text('Add new plant', style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Add plant',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF38604F),
    );
  }// Widget build

}
