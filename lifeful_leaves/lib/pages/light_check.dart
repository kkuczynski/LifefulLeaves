import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:light/light.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class LightCheck extends StatefulWidget {
  @override
  _LightCheckState createState() => _LightCheckState();
}

class _LightCheckState extends State<LightCheck> {
  String _luxString = 'Unknown';
  String _description = 'Unknown';
  Light _light;
  StreamSubscription _subscription;

  void onData(int luxValue) async {
    //print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";
      if (luxValue < 500) {
        _description = 'b. słabe oświetlenie';
      } else if (luxValue < 2500) {
        _description = 'słabe oświetlenie';
      } else if (luxValue < 10000) {
        _description = "średnie oświetlenie";
      } else if (luxValue < 20000) {
        _description = 'mocne oświetlenie';
      } else if (luxValue >= 20000) {
        _description = 'b. mocne oświetlenie';
      }
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    stopListening();
    changeSystemColors(Colors.white, false);
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    changeSystemColors(Colors.black, true);
    startListening();
  }

  Future<void> changeSystemColors(Color color, bool ifWhite) async {
    await FlutterStatusbarcolor.setNavigationBarColor(color);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(ifWhite);
  }

  Future<bool> _onWillPop() async {
    //sleep(Duration(milliseconds: 200));
    changeSystemColors(Colors.white, false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //changeSystemColors(Colors.black, true);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Pomiar naświetlenia',
            style: TextStyle(
                fontFamily: 'IndieFlower', color: Colors.white, fontSize: 32),
          ),
        ),
        backgroundColor: Colors.black87,
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Oświetlenie (LX):',
                  style: TextStyle(
                      fontFamily: 'IndieFlower',
                      color: Colors.green[300],
                      fontSize: 32),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '$_luxString',
                    style: TextStyle(
                      fontFamily: 'IndieFlower',
                      color: Colors.green[300],
                      fontSize: 72,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(10, 50, 10, 20),
                  child: Text(
                    '($_description' + ')',
                    style: TextStyle(
                      fontFamily: 'IndieFlower',
                      color: Colors.green[300],
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 30),
                  child: Text(
                    'Wyłącz sztuczne źródła swiatła i ustaw telefon ekranem w stronę okna.',
                    style: TextStyle(
                        fontFamily: 'IndieFlower',
                        color: Colors.green[300],
                        fontSize: 18),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
