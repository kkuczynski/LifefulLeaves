import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:lifeful_leaves/models/plant.dart';
import 'package:lifeful_leaves/services/database_service.dart';

import 'camera.dart';

class EditPlant extends StatefulWidget {
  final CameraDescription camera;

  final DatabaseService dbService;
  final int index;
  const EditPlant({
    @required this.index,
    Key key,
    @required this.camera,
    @required this.dbService,
    File image,
    Box<Plant> box,
  }) : super(key: key);

  @override
  _EditPlantState createState() => _EditPlantState();
}

class _EditPlantState extends State<EditPlant> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final spiecesController = TextEditingController();
  final roomController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  Plant copiedPlant;
  String imagePath;
  File image;

  Future<bool> _onWillPop() async {
    //sleep(Duration(milliseconds: 200));
    widget.dbService.putPlantAtIndex(widget.index, copiedPlant);
    return true;
  }

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
    copiedPlant = widget.dbService.getPlantFromDatabase(widget.index);
    nameController.text = copiedPlant.name;
    nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length));
    spiecesController.text = copiedPlant.spieces;
    spiecesController.selection = TextSelection.fromPosition(
        TextPosition(offset: spiecesController.text.length));
    roomController.text = copiedPlant.room;
    roomController.selection = TextSelection.fromPosition(
        TextPosition(offset: roomController.text.length));
    descriptionController.text = copiedPlant.description;
    descriptionController.selection = TextSelection.fromPosition(
        TextPosition(offset: descriptionController.text.length));
    timeController.text = copiedPlant.daysBetweenWaterings.toString();
    timeController.selection = TextSelection.fromPosition(
        TextPosition(offset: timeController.text.length));

    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.green[700]),
              title: Text(
                'Edytuj roślinę',
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
                        child: copiedPlant.picturePath == null ||
                                copiedPlant.picturePath == ""
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
                                              image: FileImage(File(
                                                  copiedPlant.picturePath))))),
                                ))),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              onChanged: (text) => {copiedPlant.name = text},
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
                              onChanged: (text) => {copiedPlant.spieces = text},
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
                              onChanged: (text) => {copiedPlant.room = text},
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
                              onChanged: (text) =>
                                  {copiedPlant.description = text},
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
                              onChanged: (text) => {
                                copiedPlant.daysBetweenWaterings =
                                    int.parse(text)
                              },
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
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
                                            color: Colors.green[300],
                                            width: 2.0)),
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
            )));
  }

  _goToCamera(BuildContext context) async {
    this.imagePath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Camera(camera: widget.camera)),
    );
    print(this.imagePath);
    if (this.imagePath == null || this.imagePath == "") {
    } else {
      copiedPlant.picturePath = imagePath;
    }
    setState(() {});
  }

  _savePlant() {
    copiedPlant.name = nameController.text;
    copiedPlant.spieces = spiecesController.text;
    copiedPlant.room = roomController.text;
    copiedPlant.description = descriptionController.text;
    copiedPlant.daysBetweenWaterings = int.parse(timeController.text);
    copiedPlant.picturePath = imagePath;
    widget.dbService.putPlantAtIndex(widget.index, copiedPlant);
    Navigator.pop(context, widget.dbService.getPlantBoxLength());
  }
}
