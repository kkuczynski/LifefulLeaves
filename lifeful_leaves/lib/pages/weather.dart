import 'package:flutter/material.dart';
import 'package:lifeful_leaves/services/daily_weather_service.dart';
import 'package:lifeful_leaves/services/database_service.dart';
import 'package:web_scraper/web_scraper.dart';

class Weather extends StatefulWidget {
  final DatabaseService dbService;
  final DailyWeatherService dailyWeatherService;
  const Weather({
    Key key,
    @required this.dbService,
    @required this.dailyWeatherService,
  }) : super(key: key);
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  //final String weatherStationIP = 'http://192.168.8.105/';

  //List<Map<String, dynamic>> fetched;
  String fetched;
  int tempIndex;
  int humIndex;
  String fetchedTemperature = "";
  String fetchedHumidity = "";
  void fetch() async {
    var webScraper =
        WebScraper(widget.dbService.getSettingsBox().weatherStationAddress);
    // Loads web page and downloads into local state of library
    if (await webScraper
        .loadWebPage(widget.dbService.getSettingsBox().weatherStationAddress)) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        fetched = webScraper.getPageContent();
        tempIndex = fetched.indexOf('*C');
        tempIndex = fetched.lastIndexOf('>', tempIndex) + 3;
        fetchedTemperature = fetched.substring(tempIndex, tempIndex + 5);
        humIndex = fetched.indexOf('Humidity');
        humIndex = fetched.indexOf('%', humIndex);
        fetchedHumidity = fetched.substring(humIndex - 8, humIndex - 3);
        widget.dailyWeatherService.dailyWeatherUpdate();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green[700]),
        title: Text(
          'Stacja pogody',
          style: TextStyle(
              fontFamily: 'IndieFlower',
              color: Colors.green[700],
              fontSize: 32),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      '\tTemperatura:',
                      style: TextStyle(
                        fontFamily: 'IndieFlower',
                        color: Colors.green[700],
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: fetched == null
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          : Text(
                              '$fetchedTemperature' + '°C',
                              style: TextStyle(
                                fontFamily: 'IndieFlower',
                                color: Colors.black,
                                fontSize: 40,
                              ),
                              textAlign: TextAlign.left,
                            ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      '\tWilgotność:',
                      style: TextStyle(
                        fontFamily: 'IndieFlower',
                        color: Colors.green[700],
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: fetched == null
                          ? CircularProgressIndicator(strokeWidth: 2)
                          : Text(
                              '$fetchedHumidity' + '%',
                              style: TextStyle(
                                fontFamily: 'IndieFlower',
                                color: Colors.black,
                                fontSize: 40,
                              ),
                              textAlign: TextAlign.left,
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.fetch();
        },
        child: Container(
          width: 51,
          height: 51,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green[700], width: 2.0)),
          child: Icon(
            Icons.refresh_outlined,
            color: Colors.green[700],
            size: 30.0,
          ),
        ),
        backgroundColor: Colors.green[300],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
