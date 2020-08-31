import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/location.dart';
import 'package:foodie/src/models/location.dart';

class LocationProvider with ChangeNotifier {
  LocationServices _locationServices = LocationServices();
  List<LocationModel> locations = [];
  LocationModel userLocation;
  LocationProvider.initialize() {
    _loadLocations();
  }

  _loadLocations() async {
    locations = await _locationServices.getLocations();
    userLocation = locations[0];
    notifyListeners();
  }

  changeLcation({LocationModel newLocation}) {
    userLocation = newLocation;
    notifyListeners();
  }
}
