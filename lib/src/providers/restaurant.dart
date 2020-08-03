import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/restaurant.dart';
import 'package:foodie/src/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  RestaurantProvider.initialize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    restaurants = await restaurantServices.getRestaurants();
    notifyListeners();
  }
}
