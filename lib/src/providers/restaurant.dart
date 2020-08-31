import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/restaurant.dart';
import 'package:foodie/src/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices restaurantServices = RestaurantServices();
  List<RestaurantModel> popularRestaurants = [];
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> restaurantsSearched = [];
  RestaurantModel restaurant;
  String restaurantName;
  RestaurantProvider.initialize() {
    _loadPopularRestaurants();
  }

  loadRestaurants() async {
    restaurants = await restaurantServices.getRestaurants();
    notifyListeners();
  }

  _loadPopularRestaurants() async {
    popularRestaurants = await restaurantServices.getPopularRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({String restaurantId}) async {
    restaurant = await restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future searchedRestaurants({String restaurantName}) async {
    restaurantsSearched = await restaurantServices.searchRestaurants(
        restaurantName: restaurantName);
    print("Res no:" + restaurantsSearched.length.toString());
    notifyListeners();
  }

  Future getRestaurantName({String restaurantId}) async {
    RestaurantModel _restautant =
        await restaurantServices.getRestaurantById(id: restaurantId);
    restaurantName = _restautant.name;
  }
}
