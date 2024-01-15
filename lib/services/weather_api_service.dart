import 'package:weather/weather.dart';

class WeatherApiService {
  final WeatherFactory _wf = WeatherFactory("d16d476239bff9abed68bc656c544e5a");

  Future<Weather> getWeatherByLocation(double lat, double lon) async {
    var weather = await _wf.currentWeatherByLocation(lat, lon);
    return weather;
  }
}
