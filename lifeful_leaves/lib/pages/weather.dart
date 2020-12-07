import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  //final String weatherStationIP = 'http://192.168.8.105/';
  final webScraper = WebScraper('http://192.168.8.105/');
  //List<Map<String, dynamic>> fetched;
  String fetched;
  int tempIndex;
  int humIndex;
  String fetchedTemperature = "";
  String fetchedHumidity = "";
  void fetch() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('http://192.168.8.105/')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        fetched = webScraper.getPageContent();
        tempIndex = fetched.indexOf('*C');
        tempIndex = fetched.lastIndexOf('>', tempIndex) + 3;
        fetchedTemperature = fetched.substring(tempIndex, tempIndex + 7);
        humIndex = fetched.indexOf('Humidity');
        humIndex = fetched.indexOf('%', humIndex);
        fetchedHumidity = fetched.substring(humIndex - 8, humIndex - 3);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Requesting to fetch before UI drawing starts
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
        child: fetched == null
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ), // Loads Circular Loading Animation
              )
            : Column(
                children: [Text(fetchedHumidity+'%'), Text(fetchedTemperature+'*C')],
              ),
      ),
    );
  }
}
