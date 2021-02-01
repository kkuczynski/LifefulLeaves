import 'package:lifeful_leaves/services/database_service.dart';
import 'package:web_scraper/web_scraper.dart';

class DailyWeatherService {
  DatabaseService dbService;
  DailyWeatherService(this.dbService);
  String fetchedTemperature;
  String fetchedHumidity;
  final timeout = const Duration(seconds: 10);
  final ms = const Duration(milliseconds: 1);

  getTodaysWeather() async {
    var webScraper =
        WebScraper(dbService.getSettingsBox().weatherStationAddress);
    // Loads web page and downloads into local state of library
    if (null !=
        await webScraper
            .loadWebPage(dbService.getSettingsBox().weatherStationAddress)
            .timeout(timeout, onTimeout: () => _onTimeout())) {
      // getElement takes the address of html tag/element and attributes you want to scrap from website
      // it will return the attributes in the same order passed
      var fetched = webScraper.getPageContent();
      int tempIndex = fetched.indexOf('*C');
      tempIndex = fetched.lastIndexOf('>', tempIndex) + 3;
      fetchedTemperature = fetched.substring(tempIndex, tempIndex + 5);
      int humIndex = fetched.indexOf('Humidity');
      humIndex = fetched.indexOf('%', humIndex);
      fetchedHumidity = fetched.substring(humIndex - 8, humIndex - 3);
    }
  }

  _onTimeout() {
    fetchedTemperature = dbService.getSettingsBox().tmpTemperature.toString();
    fetchedHumidity = dbService.getSettingsBox().tmpHumidity.toString();
  }

  dailyWeatherUpdate() async {
    await getTodaysWeather();
    dbService.addWeeklyCondition(
        double.parse(fetchedHumidity), double.parse(fetchedTemperature));
    print('done');
  }
}
