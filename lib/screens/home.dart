import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_garden/components/plant_list.dart';
import 'package:my_garden/screens/add_plant.dart';
import 'package:provider/provider.dart';

import '../components/plantlist_provider.dart';
import '../entities/plant.dart';
import '../service/plant_service.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  final _plantsService = PlantService();
  List<Plant> plants = [];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final plantService = PlantService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _fetchPlants();
    });
  }


  void _fetchPlants() async {
    final fetchedPlants = await widget._plantsService.getPlant();
    /*Provider.of<PlantListProvider>(context as BuildContext, listen: false)
        .addPlant(fetchedPlants as Plant);
    setState(() {});*/
    Provider.of<PlantListProvider>(context as BuildContext, listen: false).setPlants(fetchedPlants);
  }



  @override
  Widget build(BuildContext context) {
    final plantList = Provider.of<PlantListProvider>(context);
    return Scaffold(
        appBar: buildAppBar(),
        endDrawer: buildDrawer(),
        floatingActionButton: buildFloatingActionButton(context),
        body: Column(
          children: [
            _searchField(),
            SingleChildScrollView(
              child: SizedBox(
                  height: 550.0,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff82A596)), // Add border
                      borderRadius: BorderRadius.circular(10.0), // Add rounded corners
                    ),
                  child: PlantList(plants: plantList.allPlants)
                ),
              ),
            )
          ],
        ),
      );
  }


  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPlant()));},
      backgroundColor: const Color(0xFF38604F),
      child: const Icon(Icons.add),);
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 30,left: 20,right: 20, bottom: 30),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color(0xff1D1617).withOpacity(0.15),
                blurRadius: 40,
                spreadRadius: 0.0
            )
          ]
      ),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search plant',
            hintStyle: const TextStyle(
                color: Color(0xffDDDADA),
                fontSize: 14
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.search),
            ),
            suffixIcon: const SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.filter_alt_outlined),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
            )
        ),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xff82A596),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
                accountName: Text('Name Surname'),
                accountEmail: Text('name@gmail.com'),
                currentAccountPicture: CircleAvatar(),
                decoration: BoxDecoration(color: Colors.transparent)
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.white,),
              title: Text('Favourites', style: TextStyle(color: Colors.white)),
              //onTap: () => ,
            ),
            ListTile(
              leading: Icon(Icons.folder, color: Colors.white,),
              title: Text('My collections', style: TextStyle(color: Colors.white)),
              //onTap: () => ,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white,),
              title: Text('Settings', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white,),
              title: Text('Log out', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        title: const Text('My Garden',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF38604F),
        actions: [Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.white,
                onPressed: () { Scaffold.of(context).openEndDrawer(); },
              );
            }
        )]
    );
  }


  void confirm(){}
}
