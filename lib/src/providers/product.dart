import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/product.dart';
import 'package:foodie/src/models/products.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];
  ProductProvider.initialize() {
    //_loadProducts();
    _loadFeaturedProducts();
  }

  // _loadProducts() async {
  //   products = await _productServices.getProducts();
  //   notifyListeners();
  // }

  _loadFeaturedProducts() async {
    products = await _productServices.getFeaturedProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory =
        await _productServices.getProductsFromCategory(category: categoryName);
    notifyListeners();
  }

  Future loadProductsByRestaurant({int id}) async {
    productsByRestaurant =
        await _productServices.getProductsFromRestaurant(id: id);
    notifyListeners();
  }

  Future searchedProducts({String productName}) async {
    productsSearched =
        await _productServices.searchProducts(productName: productName);
    print("no:" + productsSearched.length.toString());
    notifyListeners();
  }
}
