import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/category.dart';
import 'package:foodie/src/models/category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];
  CategoryProvider.initialize() {
    _loadCategories();
  }

  _loadCategories() async {
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}
