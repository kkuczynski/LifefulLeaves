import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeful_leaves/models/plant_with_index.dart';
import 'package:lifeful_leaves/pages/menu.dart';
import 'package:lifeful_leaves/services/daily_weather_service.dart';
import 'package:lifeful_leaves/services/database_service.dart';
import 'package:lifeful_leaves/services/watering_service.dart';
import 'package:lifeful_leaves/widgets/bottom_fade%20copy.dart';
import 'package:lifeful_leaves/widgets/bottom_fade.dart';

class Home extends StatefulWidget {
  final DatabaseService dbService;
  final DailyWeatherService dailyWeatherService;
  final WateringService wateringService;
  const Home({
    Key key,
    @required this.dbService,
    @required this.dailyWeatherService,
    @required this.wateringService,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> text = [0, 1, 2, 3, 4, 5, 6];
  List<PlantWithIndex> plantsToWater;
  int listLength = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    plantsToWater = widget.wateringService.getPlantsToWaterTodayList();
    if (plantsToWater != null) {
      listLength = plantsToWater.length;
    }
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.white, Colors.white])),
              width: double.infinity,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    // RaisedButton(
                    //     onPressed: () =>
                    //         widget.dailyWeatherService.dailyWeatherUpdate()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Warunki z ostatnich 7 dni',
                            style: TextStyle(
                                fontSize: 24, color: Colors.green[700])),
                        Text(':',
                            style: TextStyle(
                                fontSize: 40, color: Colors.green[700]))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  'temp.:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'wilg.:',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            )),
                        for (var i in text)
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          width: 1, color: Colors.green[700]))),
                              padding: EdgeInsets.all(2),
                              child: Column(
                                children: [
                                  Text(
                                    widget.dbService
                                            .getWeeklyConditions()
                                            .temperature[i]
                                            .toString() +
                                        '°C',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    widget.dbService
                                            .getWeeklyConditions()
                                            .humidity[i]
                                            .toString() +
                                        '%',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text('Do podlania dzisiaj',
                          style: TextStyle(
                              fontSize: 32, color: Colors.green[700])),
                    ),
                    listLength > 0
                        ? Stack(children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 211,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: listLength,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Stack(children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                Colors.green[700],
                                                Colors.green[300]
                                              ])),
                                          child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 2, 2, 0),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Colors.green[50],
                                                      Colors.white
                                                    ]),
                                              ),
                                              child: Column(children: [
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          width: width - 250,
                                                          height: width - 250,
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  right: BorderSide(
                                                                      width: 2,
                                                                      color: Colors.green[
                                                                          700]),
                                                                  bottom: BorderSide(
                                                                      width: 2,
                                                                      color: Colors.green[
                                                                          700]))),
                                                          child: plantsToWater[index]
                                                                          .plant
                                                                          .picturePath ==
                                                                      null ||
                                                                  File(plantsToWater[index].plant.picturePath) ==
                                                                      null
                                                              ? Icon(
                                                                  Icons.eco,
                                                                  size: 64,
                                                                  color: Colors
                                                                          .green[
                                                                      700],
                                                                )
                                                              : AspectRatio(
                                                                  aspectRatio:
                                                                      1 / 1,
                                                                  child: Container(
                                                                      decoration:
                                                                          BoxDecoration(image: DecorationImage(fit: BoxFit.cover, alignment: FractionalOffset.topCenter, image: FileImage(File(plantsToWater[index].plant.picturePath))))))),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 196,
                                                            child: Text(
                                                              plantsToWater[
                                                                      index]
                                                                  .plant
                                                                  .name,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'IndieFlower',
                                                                color: Colors
                                                                    .green[700],
                                                                fontSize: 44,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Container(
                                                              width: 194,
                                                              margin: const EdgeInsets
                                                                      .fromLTRB(
                                                                  2, 0, 0, 0),
                                                              child: Text(
                                                                '${plantsToWater[index].plant.room}',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'IndieFlower',
                                                                    color: Colors
                                                                            .green[
                                                                        700],
                                                                    fontSize:
                                                                        20),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )),
                                                        ],
                                                      ),
                                                    ]),
                                              ]))),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              RawMaterialButton(
                                                highlightColor:
                                                    Colors.transparent,
                                                splashColor: Colors.transparent,
                                                onPressed: () {
                                                  widget.wateringService
                                                      .waterPlant(
                                                          plantsToWater[index]
                                                              .index);
                                                  plantsToWater = widget
                                                      .wateringService
                                                      .getPlantsToWaterTodayList();
                                                  setState(() {});
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Podlej",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'IndieFlower',
                                                          color:
                                                              Colors.blue[900],
                                                          fontSize: 18),
                                                    ),
                                                    Container(
                                                      child: Container(
                                                        width: 51,
                                                        height: 51,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors
                                                                .blue[300],
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue[900],
                                                                width: 2.0)),
                                                        child: Icon(
                                                          Icons.opacity,
                                                          color:
                                                              Colors.blue[900],
                                                          size: 30.0,
                                                        ),
                                                      ),
                                                      width: 54,
                                                      height: 54,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.8),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset:
                                                                  Offset(0, 3),
                                                            ),
                                                          ],
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .blue[300],
                                                              width: 2.0)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ))
                                    ]);
                                  }),
                            ),
                            TopFade(
                              height: 50,
                            )
                          ])
                        : Column(
                            children: [
                              SizedBox(height: 100),
                              Align(
                                alignment: Alignment.center,
                                child: Text('Brak roślin do podlania!',
                                    style: TextStyle(fontSize: 32)),
                              ),
                            ],
                          )
                  ],
                ),
              )),
          BottomFade(
            height: 80,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMenu();
        },
        child: Container(
          width: 51,
          height: 51,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green[700], width: 2.0)),
          child: Icon(
            Icons.apps,
            color: Colors.green[700],
            size: 30.0,
          ),
        ),
        backgroundColor: Colors.green[300],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void openMenu() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Menu()),
    );

    setState(() {});
  }
}
