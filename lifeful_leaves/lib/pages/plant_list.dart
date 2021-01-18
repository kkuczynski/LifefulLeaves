import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lifeful_leaves/pages/add_plant.dart';
import 'package:lifeful_leaves/services/database_service.dart';

class PlantList extends StatefulWidget {
  final DatabaseService dbService;
  final CameraDescription camera;
  const PlantList({
    Key key,
    @required this.dbService,
    @required this.camera,
  }) : super(key: key);

  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  int dbLength;

  @override
  Widget build(BuildContext context) {
    this.dbLength = widget.dbService.getPlantBoxLength();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green[700]),
        title: Text(
          'Moje rośliny',
          style: TextStyle(
              fontFamily: 'IndieFlower',
              color: Colors.green[700],
              fontSize: 32),
        ),
      ),
      body: Text(widget.dbService.getPlantBoxLength().toString()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddPlantPage(),
        child: Container(
          width: 51,
          height: 51,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green[700], width: 2.0)),
          child: Icon(
            Icons.add,
            color: Colors.green[700],
            size: 30.0,
          ),
        ),
        backgroundColor: Colors.green[300],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  openAddPlantPage() async {
    int newDbLength = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              AddPlant(camera: widget.camera, dbService: widget.dbService)),
    );

    if (this.dbLength < newDbLength) {
      setState(() {});
    }
  }
}
