import 'package:lifeful_leaves/services/database_service.dart';
import 'package:web_scraper/web_scraper.dart';

class DailyWeatherService {
  DatabaseService dbService;
  DailyWeatherService(this.dbService);
  String fetchedTemperature;
  String fetchedHumidity;
  bool usedStation = false;
  final timeout = const Duration(seconds: 10);
  final ms = const Duration(milliseconds: 1);

  getTodaysWeather() async {
    var webScraper =
        WebScraper(dbService.getSettingsBox().weatherStationAddress);

    if (null !=
        await webScraper
            .loadWebPage(dbService.getSettingsBox().weatherStationAddress)
            .timeout(timeout, onTimeout: () => _onTimeout())) {
      var fetched = webScraper.getPageContent();
      int tempIndex = fetched.indexOf('*C');
      tempIndex = fetched.lastIndexOf('>', tempIndex) + 3;
      fetchedTemperature = fetched.substring(tempIndex, tempIndex + 5);
      int humIndex = fetched.indexOf('Humidity');
      humIndex = fetched.indexOf('%', humIndex);
      fetchedHumidity = fetched.substring(humIndex - 8, humIndex - 3);
      usedStation = true;
    }
  }

  _onTimeout() {
    fetchedTemperature = dbService.getSettingsBox().tmpTemperature.toString();
    fetchedHumidity = dbService.getSettingsBox().tmpHumidity.toString();
    usedStation = false;
  }

  dailyWeatherUpdate() async {
    await getTodaysWeather();

    if (usedStation) {
      int dayOfTheWeek = DateTime.now().weekday;
      dbService.addWeeklyCondition(double.parse(fetchedHumidity),
          double.parse(fetchedTemperature), dayOfTheWeek);
    } else {
      dbService.addWeeklyCondition(
          double.parse(fetchedHumidity), double.parse(fetchedTemperature), -1);
    }
    print('Weather updated');
  }
}
