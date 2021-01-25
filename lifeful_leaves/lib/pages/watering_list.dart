import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifeful_leaves/services/database_service.dart';
import 'package:lifeful_leaves/services/watering_service.dart';

class WateringList extends StatefulWidget {
  final DatabaseService dbService;
  final WateringService wateringService;
  const WateringList({
    Key key,
    @required this.dbService,
    @required this.wateringService,
  }) : super(key: key);

  @override
  _WateringListState createState() => _WateringListState();
}

class _WateringListState extends State<WateringList> {
  int dbLength;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    this.dbLength = widget.dbService.getPlantBoxLength();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue[900]),
        title: Text(
          'Do podlania',
          style: TextStyle(
              fontFamily: 'IndieFlower', color: Colors.blue[900], fontSize: 32),
        ),
      ),
      body: dbLength > 0
          ? ListView.builder(
              itemCount: dbLength,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue[900], Colors.green[300]])),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 2, 2, 0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.white, Colors.white]),
                        ),
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: width - 250,
                                      height: width - 250,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 2,
                                                  color: Colors.blue[900]),
                                              bottom: BorderSide(
                                                  width: 2,
                                                  color: Colors.blue[900]))),
                                      child: widget.dbService
                                                      .getPlantFromDatabase(
                                                          index)
                                                      .picturePath ==
                                                  null ||
                                              File(widget.dbService.getPlantFromDatabase(index).picturePath) ==
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
                                                          image:
                                                              FileImage(File(widget.dbService.getPlantFromDatabase(index).picturePath))))))),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 196,
                                        child: Text(
                                          widget.dbService
                                              .getPlantFromDatabase(index)
                                              .name,
                                          style: TextStyle(
                                            fontFamily: 'IndieFlower',
                                            color: Colors.blue[900],
                                            fontSize: 44,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                          width: 194,
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 0, 0, 0),
                                          child: Text(
                                            '${widget.dbService.getPlantFromDatabase(index).room}',
                                            style: TextStyle(
                                                fontFamily: 'IndieFlower',
                                                color: Colors.green[700],
                                                fontSize: 20),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ],
                                  ),
                                ]),
                            Container(
                                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                width: width - 4,
                                child: widget.dbService
                                            .getPlantFromDatabase(index)
                                            .nextWatering ==
                                        null
                                    ? Text(
                                        'należy podlać: brak danych',
                                        style: TextStyle(
                                            fontFamily: 'IndieFlower',
                                            color: Colors.green[700],
                                            fontSize: 27),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        'należy podlać: ${widget.dbService.getPlantFromDatabase(index).nextWatering.day}.${widget.dbService.getPlantFromDatabase(index).nextWatering.month}.${widget.dbService.getPlantFromDatabase(index).nextWatering.year}',
                                        style: TextStyle(
                                            fontFamily: 'IndieFlower',
                                            color: Colors.green[700],
                                            fontSize: 27),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                            Container(
                                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                width: width - 4,
                                child: widget.dbService
                                            .getPlantFromDatabase(index)
                                            .lastWatering ==
                                        null
                                    ? Text(
                                        'ostatnie podlewanie: brak danych',
                                        style: TextStyle(
                                            fontFamily: 'IndieFlower',
                                            color: Colors.green[700],
                                            fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        'ostatnie podlewanie: ${widget.dbService.getPlantFromDatabase(index).lastWatering.day}.${widget.dbService.getPlantFromDatabase(index).lastWatering.month}.${widget.dbService.getPlantFromDatabase(index).lastWatering.year}',
                                        style: TextStyle(
                                            fontFamily: 'IndieFlower',
                                            color: Colors.green[700],
                                            fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 90,
                          ),
                          RawMaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              widget.wateringService.waterPlant(index);
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Podlej",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'IndieFlower',
                                      color: Colors.blue[900],
                                      fontSize: 18),
                                ),
                                Container(
                                  child: Container(
                                    width: 51,
                                    height: 51,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[300],
                                        border: Border.all(
                                            color: Colors.blue[900],
                                            width: 2.0)),
                                    child: Icon(
                                      Icons.opacity,
                                      color: Colors.blue[900],
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
                                          color: Colors.blue[300], width: 2.0)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
}
