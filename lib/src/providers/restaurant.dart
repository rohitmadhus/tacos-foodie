import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/restaurant.dart';
import 'package:foodie/src/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> restaurantsSearched = [];
  RestaurantModel restaurant;
  RestaurantProvider.initialize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    restaurants = await restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({int restaurantId}) async {
    restaurant = await restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future searchedRestaurants({String restaurantName}) async {
    restaurantsSearched = await restaurantServices.searchRestaurants(
        restaurantName: restaurantName);
    print("Res no:" + restaurantsSearched.length.toString());
    notifyListeners();
  }
}
