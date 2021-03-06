import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeful_leaves/models/plant.dart';
import 'package:lifeful_leaves/services/database_service.dart';

import 'camera.dart';

class AddPlant extends StatefulWidget {
  final CameraDescription camera;

  final DatabaseService dbService;
  const AddPlant({
    Key key,
    @required this.camera,
    @required this.dbService,
    File image,
  }) : super(key: key);

  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final spiecesController = TextEditingController();
  final roomController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  String imagePath;
  File image;
  Plant newPlant = Plant();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    spiecesController.dispose();
    roomController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    super.dispose();
  }

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
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        : AspectRatio(
                            aspectRatio: 1 / 1,
                            child: RawMaterialButton(
                                onPressed: () {
                                  _goToCamera(context);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            alignment:
                                                FractionalOffset.topCenter,
                                            image: FileImage(
                                                File(imagePath)))))))),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nazwa',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Nazwij roślinę';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: spiecesController,
                          decoration: const InputDecoration(
                            labelText: 'Gatunek',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Podaj gatunek';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: roomController,
                          decoration: const InputDecoration(
                            labelText: 'Pomieszczenie',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Podaj pomieszczenie';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            labelText: 'Opis',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Opisz roślinę';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Podaj ilość dni';
                            }
                            return null;
                          },
                          controller: timeController,
                          decoration: const InputDecoration(
                              labelText: 'Dni między podlewaniem',
                              hintText: 'Latem przy niskiej wilgotności'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RawMaterialButton(
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                if (_formKey.currentState.validate()) {
                                  _savePlant();
                                }
                              },
                              child: Container(
                                child: Container(
                                  width: 51,
                                  height: 51,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green[300],
                                      border: Border.all(
                                          color: Colors.green[700],
                                          width: 2.0)),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green[700],
                                    size: 30.0,
                                  ),
                                ),
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.8),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.green[300], width: 2.0)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _goToCamera(BuildContext context) async {
    this.imagePath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Camera(camera: widget.camera)),
    );
    print(this.imagePath);
    this.newPlant.picturePath = imagePath;
    setState(() {});
  }

  _savePlant() {
    newPlant.name = nameController.text;
    newPlant.spieces = spiecesController.text;
    newPlant.room = roomController.text;
    newPlant.description = descriptionController.text;
    newPlant.daysBetweenWaterings = int.parse(timeController.text);
    widget.dbService.addPlantToDatabase(newPlant);
    Navigator.pop(context, widget.dbService.getPlantBoxLength());
  }
}
