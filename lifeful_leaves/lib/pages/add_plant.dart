import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lifeful_leaves/models/plant.dart';

import 'camera.dart';

class AddPlant extends StatefulWidget {
  final CameraDescription camera;
  const AddPlant({
    Key key,
    @required this.camera,
    File image,
  }) : super(key: key);

  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  String imagePath;
  File image;
  Plant newPlant = Plant();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green[700]),
          title: Text(
            'Dodaj roślinę',
            style: TextStyle(
                fontFamily: 'IndieFlower',
                color: Colors.green[700],
                fontSize: 32),
          ),
        ),
        body: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(10),
                        width: width - 20,
                        height: width - 20,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green[700])),
                        child: imagePath == null
                            ? IconButton(
                                icon: Icon(Icons.camera_alt_outlined),
                                onPressed: () {
                                  _goToCamera(context);
                                },
                                iconSize: 80,
                                color: Colors.green[700],
                              )
                            : Image.file(File(imagePath))),
                  ],
                )
              ],
            )));
  }

  _goToCamera(BuildContext context) async {
    this.imagePath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Camera(camera: widget.camera)),
    );
    print(this.imagePath);
    setState(() {});
  }
}
