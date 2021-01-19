import 'dart:io';

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
    double width = MediaQuery.of(context).size.width;
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
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () => openAddPlantPage(),
                    child: Icon(
                      Icons.add,
                      size: 26.0,
                      color: Colors.green[700],
                    )))
          ]),
      body: dbLength > 0
          ? ListView.builder(
              itemCount: dbLength,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.green[700], Colors.white])),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 2, 2, 0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.green[50], Colors.white]),
                    ),
                    child: Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: width - 200,
                                  height: width - 200,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 2,
                                              color: Colors.green[700]),
                                          bottom: BorderSide(
                                              width: 2,
                                              color: Colors.green[700]))),
                                  child: widget.dbService
                                                  .getPlantFromDatabase(index)
                                                  .picturePath ==
                                              null ||
                                          File(widget.dbService
                                                  .getPlantFromDatabase(index)
                                                  .picturePath) ==
                                              null
                                      ? Icon(
                                          Icons.eco,
                                          size: 64,
                                          color: Colors.green[700],
                                        )
                                      : AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          FractionalOffset
                                                              .topCenter,
                                                      image: FileImage(File(widget.dbService.getPlantFromDatabase(index).picturePath))))))),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 196,
                                    child: Text(
                                      widget.dbService
                                          .getPlantFromDatabase(index)
                                          .name,
                                      style: TextStyle(
                                        fontFamily: 'IndieFlower',
                                        color: Colors.black,
                                        fontSize: 44,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                      width: 194,
                                      margin:
                                          const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                      child: Text(
                                        '${widget.dbService.getPlantFromDatabase(index).spieces}',
                                        style: TextStyle(
                                            fontFamily: 'IndieFlower',
                                            color: Colors.green[700],
                                            fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Container(
                                      width: 194,
                                      margin:
                                          const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                      child: Text(
                                        '${widget.dbService.getPlantFromDatabase(index).room}',
                                        style: TextStyle(
                                            fontFamily: 'IndieFlower',
                                            color: Colors.green[700],
                                            fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Container(
                                      width: 194,
                                      margin:
                                          const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                      child: Text(
                                        'podlewać co ${widget.dbService.getPlantFromDatabase(index).daysBetweenWaterings} dni',
                                        style: TextStyle(
                                            fontFamily: 'IndieFlower',
                                            color: Colors.green[700],
                                            fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              ),
                            ]),
                        Container(
                            margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                            width: width - 4,
                            child: Text(
                              widget.dbService
                                  .getPlantFromDatabase(index)
                                  .description,
                              style: TextStyle(
                                  fontFamily: 'IndieFlower',
                                  color: Colors.black45,
                                  fontSize: 16),
                              overflow: TextOverflow.clip,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RawMaterialButton(
                                onPressed: null,
                                child: Container(
                                  child: Container(
                                    width: 37,
                                    height: 37,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70,
                                        border: Border.all(
                                            color: Colors.black45, width: 2.0)),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.black45,
                                      size: 24.0,
                                    ),
                                  ),
                                  width: 40,
                                  height: 40,
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
                                          color: Colors.white70, width: 2.0)),
                                )),
                            RawMaterialButton(
                                onPressed: null,
                                child: Container(
                                  child: Container(
                                    width: 37,
                                    height: 37,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green[300],
                                        border: Border.all(
                                            color: Colors.green[700],
                                            width: 2.0)),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.green[700],
                                      size: 24.0,
                                    ),
                                  ),
                                  width: 40,
                                  height: 40,
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
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: const Text(
                'Brak roślin :c',
                style: TextStyle(fontFamily: 'IndieFlower', fontSize: 32),
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => openAddPlantPage(),
      //   child: Container(
      //     width: 51,
      //     height: 51,
      //     decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         border: Border.all(color: Colors.green[700], width: 2.0)),
      //     child: Icon(
      //       Icons.add,
      //       color: Colors.green[700],
      //       size: 30.0,
      //     ),
      //   ),
      //   backgroundColor: Colors.green[300],
      // ),
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
