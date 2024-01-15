import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:task_flow/app/app.locator.dart';
import 'package:task_flow/app/app.logger.dart';

import '../../../services/geolocation_service.dart';
import '../../../services/weather_api_service.dart';

class WeatherViewModel extends BaseViewModel {
  final _weatherService = locator<WeatherApiService>();
  final _locationService = locator<GeolocationService>();
  String _currentTemp = '';
  String _sunriseTime = '';
  String _sunsetTime = '';
  String _tempMax = '';
  String _tempMin = '';
  String _currentDate = '';
  String _locationName = '';
  int _weatherCode = 0;

  final _log = getLogger('WeatherViewModel');

  String get currentTemp => _currentTemp;

  String get sunriseTime => _sunriseTime;

  String get sunsetTime => _sunsetTime;

  String get tempMax => _tempMax;

  String get tempMin => _tempMin;

  String get currentDate => _currentDate;

  String get locationName => _locationName;

  int get weatherCode => _weatherCode;

  final _timeFormatter = DateFormat('HH:mm');
  final _dateFormatter = DateFormat('E dd - HH:mm');

  init() {
    getWeather();
  }

  getWeather() async {
    setBusy(true);

    var model = await _locationService.getLocation();
    _log.i('${model.latitude} ,${model.longitude}');

    var weather = await _weatherService.getWeatherByLocation(
        model.latitude, model.longitude);

    _currentTemp =
        weather.temperature?.celsius?.toInt().toString() ?? 'no temp';

    _currentDate = _dateFormatter.format(weather.date ?? DateTime.now());

    _sunriseTime = _timeFormatter.format(weather.sunrise ?? DateTime.now());
    _sunsetTime = _timeFormatter.format(weather.sunset ?? DateTime.now());

    _tempMax = weather.tempMax?.celsius?.toInt().toString() ?? 'no temp';
    _tempMin = weather.tempMin?.celsius?.toInt().toString() ?? 'no temp';

    _locationName = weather.areaName ?? 'no location';

    _weatherCode = weather.weatherConditionCode ?? 0;

    print("weather-code : ${_weatherCode}");

    setBusy(false);
  }
}
