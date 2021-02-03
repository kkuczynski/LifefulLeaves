import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeful_leaves/models/settings.dart';
import 'package:lifeful_leaves/services/database_service.dart';
import 'package:lifeful_leaves/services/ip_service.dart';

class SettingsPage extends StatefulWidget {
  final DatabaseService dbService;

  const SettingsPage({
    Key key,
    @required this.dbService,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController temperatureController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController ipController1 = TextEditingController();
  TextEditingController ipController2 = TextEditingController();
  TextEditingController ipController3 = TextEditingController();
  TextEditingController ipController4 = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  final IpService ipService = IpService();
  Settings settings;
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    temperatureController.dispose();
    humidityController.dispose();
    ipController1.dispose();
    ipController2.dispose();
    ipController3.dispose();
    ipController4.dispose();
    hourController.dispose();
    minuteController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    //sleep(Duration(milliseconds: 200));
    widget.dbService.saveSettings(settings);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    settings = widget.dbService.getSettingsBox();
    temperatureController.text = settings.tmpTemperature.toString();
    temperatureController.selection = TextSelection.fromPosition(
        TextPosition(offset: temperatureController.text.length));
    humidityController.text = settings.tmpHumidity.toString();
    humidityController.selection = TextSelection.fromPosition(
        TextPosition(offset: humidityController.text.length));
    ipController1.text = ipService.cut(settings.weatherStationAddress, 1);
    ipController1.selection = TextSelection.fromPosition(
        TextPosition(offset: ipController1.text.length));
    ipController2.text = ipService.cut(settings.weatherStationAddress, 2);
    ipController2.selection = TextSelection.fromPosition(
        TextPosition(offset: ipController2.text.length));
    ipController3.text = ipService.cut(settings.weatherStationAddress, 3);
    ipController3.selection = TextSelection.fromPosition(
        TextPosition(offset: ipController3.text.length));
    ipController4.text = ipService.cut(settings.weatherStationAddress, 4);
    ipController4.selection = TextSelection.fromPosition(
        TextPosition(offset: ipController4.text.length));
    hourController.text = settings.notificationsTimeHour.toString();
    hourController.selection = TextSelection.fromPosition(
        TextPosition(offset: hourController.text.length));
    if (hourController.text.length == 1) {
      hourController.text = '0' + hourController.text;
    } else if (hourController.text.length == 0) {
      hourController.text = '00';
    }
    minuteController.text = settings.notificationsTimeMinute.toString();
    if (minuteController.text.length == 1) {
      minuteController.text = '0' + minuteController.text;
    } else if (minuteController.text.length == 0) {
      minuteController.text = '00';
    }

    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.green[700]),
              title: Text(
                'ustawienia',
                style: TextStyle(
                    fontFamily: 'IndieFlower',
                    color: Colors.green[700],
                    fontSize: 32),
              ),
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                  width: width,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                                width: width - 90,
                                child: Text(
                                    'Dostosuj częstotliwość podlewania na podstawie warunków',
                                    style: TextStyle(
                                        fontFamily: 'IndieFlower',
                                        color: Colors.black,
                                        fontSize: 18))),
                            Switch(
                                value:
                                    settings.adjustWateringsBasedOnConditions,
                                activeColor: Colors.green[700],
                                onChanged: (value) {
                                  setState(() {
                                    settings.adjustWateringsBasedOnConditions =
                                        value;
                                    widget.dbService.saveSettings(settings);
                                  });
                                })
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                                width: width - 90,
                                child: Text('Używaj stacji pogodowej',
                                    style: TextStyle(
                                        fontFamily: 'IndieFlower',
                                        color: Colors.black,
                                        fontSize: 18))),
                            Switch(
                                value: settings.useWeatherStation,
                                activeColor: Colors.green[700],
                                onChanged: (value) {
                                  setState(() {
                                    settings.useWeatherStation = value;

                                    widget.dbService.saveSettings(settings);
                                  });
                                })
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: width - 100,
                              child: Text('Domyślna temperatura',
                                  style: TextStyle(
                                      fontFamily: 'IndieFlower',
                                      color: Colors.black,
                                      fontSize: 18)),
                            ),
                            Container(
                              width: 65,
                              margin: EdgeInsets.all(3),
                              alignment: Alignment.centerRight,
                              child: TextField(
                                controller: temperatureController,
                                onChanged: (text) => {
                                  settings.tmpTemperature = double.parse(text),
                                  widget.dbService.saveSettings(settings)
                                },
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                decoration: InputDecoration(
                                  suffix: Text('°C '),
                                  counterText: "",
                                  contentPadding:
                                      EdgeInsets.fromLTRB(3, 0, 0, 0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green[700], width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5),
                                  ),
                                ),
                                //maxlength: 3,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                                width: width - 100,
                                child: Text('Domyślna wilgotność',
                                    style: TextStyle(
                                        fontFamily: 'IndieFlower',
                                        color: Colors.black,
                                        fontSize: 18))),
                            Container(
                              width: 65,
                              margin: EdgeInsets.all(3),
                              alignment: Alignment.centerRight,
                              child: TextField(
                                onChanged: (text) => {
                                  settings.tmpHumidity = double.parse(text),
                                  widget.dbService.saveSettings(settings)
                                },
                                controller: humidityController,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(7, 0, 0, 0),
                                  suffix: Text('% '),
                                  counterText: "",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green[700], width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5),
                                  ),
                                ),
                                //maxlength: 3,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text('Adres IP stacji pogodowej',
                              style: TextStyle(
                                  fontFamily: 'IndieFlower',
                                  color: Colors.black,
                                  fontSize: 18)),
                        ),
                        Container(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 40,
                                margin: EdgeInsets.all(3),
                                alignment: Alignment.centerRight,
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: ipController1,
                                    onChanged: (text) => {
                                          settings.weatherStationAddress =
                                              ipService.createIpAddress(
                                                  text,
                                                  ipController2.text,
                                                  ipController3.text,
                                                  ipController4.text),
                                          widget.dbService
                                              .saveSettings(settings)
                                        },
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(3, 0, 0, 0),
                                    ),
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ]),
                              ),
                              Text(
                                '.',
                              ),
                              Container(
                                width: 40,
                                margin: EdgeInsets.all(3),
                                alignment: Alignment.centerRight,
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: ipController2,
                                    onChanged: (text) => {
                                          settings.weatherStationAddress =
                                              ipService.createIpAddress(
                                                  ipController1.text,
                                                  text,
                                                  ipController3.text,
                                                  ipController4.text),
                                          widget.dbService
                                              .saveSettings(settings)
                                        },
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(3, 0, 0, 0),
                                    ),
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ]),
                              ),
                              Text(
                                '.',
                              ),
                              Container(
                                width: 40,
                                margin: EdgeInsets.all(3),
                                alignment: Alignment.centerRight,
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: ipController3,
                                    onChanged: (text) => {
                                          settings.weatherStationAddress =
                                              ipService.createIpAddress(
                                                  ipController1.text,
                                                  ipController2.text,
                                                  text,
                                                  ipController4.text),
                                          widget.dbService
                                              .saveSettings(settings)
                                        },
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(3, 0, 0, 0),
                                    ),
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ]),
                              ),
                              Text(
                                '.',
                              ),
                              Container(
                                width: 40,
                                margin: EdgeInsets.all(3),
                                alignment: Alignment.centerRight,
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: ipController4,
                                    onChanged: (text) => {
                                          settings.weatherStationAddress =
                                              ipService.createIpAddress(
                                                  ipController1.text,
                                                  ipController2.text,
                                                  ipController3.text,
                                                  text),
                                          widget.dbService
                                              .saveSettings(settings)
                                        },
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          EdgeInsets.fromLTRB(3, 0, 0, 0),
                                    ),
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ]),
                              ),
                              RawMaterialButton(
                                  onPressed: () => {
                                        setState(() {
                                          settings.weatherStationAddress =
                                              'http://192.168.8.105/';
                                        })
                                      },
                                  child: Container(
                                    child: Container(
                                      width: 37,
                                      height: 37,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white70,
                                          border: Border.all(
                                              color: Colors.black45,
                                              width: 2.0)),
                                      child: Icon(
                                        Icons.settings_backup_restore,
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
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text('Czas wysyłania powiadomień',
                                  style: TextStyle(
                                      fontFamily: 'IndieFlower',
                                      color: Colors.black,
                                      fontSize: 18)),
                            ),
                          ],
                        ),
                        Container(
                            width: width,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    margin: EdgeInsets.all(3),
                                    alignment: Alignment.centerRight,
                                    child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: hourController,
                                        onTap: () => scrollController.jumpTo(
                                            scrollController
                                                .position.maxScrollExtent),
                                        onChanged: (text) => {
                                              if (0 >
                                                      int.parse(hourController
                                                          .text) ||
                                                  24 <
                                                      int.parse(
                                                          hourController.text))
                                                {hourController.text = ''},
                                              settings.notificationsTimeHour =
                                                  int.parse(
                                                      hourController.text),
                                              widget.dbService
                                                  .saveSettings(settings)
                                            },
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.black),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.fromLTRB(3, 0, 0, 0),
                                        ),
                                        maxLength: 3,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ]),
                                  ),
                                  Text(
                                    ':',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                  Container(
                                    width: 40,
                                    margin: EdgeInsets.all(3),
                                    alignment: Alignment.centerRight,
                                    child: TextField(
                                        textAlign: TextAlign.center,
                                        onTap: () => scrollController.jumpTo(
                                            scrollController
                                                .position.maxScrollExtent),
                                        controller: minuteController,
                                        onChanged: (text) => {
                                              if (0 >
                                                      int.parse(minuteController
                                                          .text) ||
                                                  59 <
                                                      int.parse(minuteController
                                                          .text))
                                                {minuteController.text = ''},
                                              settings.notificationsTimeMinute =
                                                  int.parse(
                                                      minuteController.text),
                                              widget.dbService
                                                  .saveSettings(settings)
                                            },
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.black),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.fromLTRB(3, 0, 0, 0),
                                        ),
                                        maxLength: 2,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ]),
                                  ),
                                ])),
                        SizedBox(
                          height: 140,
                        )
                      ])),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green[700], width: 2.0)),
                child: Icon(
                  Icons.check,
                  color: Colors.green[700],
                  size: 30.0,
                ),
              ),
              backgroundColor: Colors.green[300],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat));
  }
}
