import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/foodType.dart';
import 'package:foodie/src/models/foodType.dart';

class FoodTypeProvider with ChangeNotifier {
  FoodTypeServices _foodTypeServices = FoodTypeServices();
  List<FoodTypeModel> foodTypes = [];
  FoodTypeProvider.initialize() {
    _loadFoodTypes();
  }

  _loadFoodTypes() async {
    foodTypes = await _foodTypeServices.getFoodTypes();
    notifyListeners();
  }
}
