import 'package:location/location.dart';

import '../models/location_model.dart';

class GeolocationService {
  final Location _location = Location();

  Future<LoacationModel> getLocation() async {
    await _location.requestPermission();
    final currentLocation = await _location.getLocation();

    var loc = LoacationModel(
      currentLocation.latitude ?? 51.514244,
      currentLocation.longitude ?? 7.468429,
    );
    return loc;
  }
}
