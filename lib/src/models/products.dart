import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  //restaurant name
  static const RESTAURANT = "restaurant";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const FOOD_TYPE = "foodType";
  static const RATES = "rates";
  //static const USER_LIKES = "userLikes";

  String _id;
  String _name;
  String _category;
  String _image;
  String _description;
  double _rating;
  String _foodType;
  bool _featured;
  int _price;
  int _rates;

  String _restaurantId;
  String _restaurant;

  String get id => _id;
  String get name => _name;
  String get restaurant => _restaurant;
  String get restaurantId => _restaurantId;
  String get category => _category;
  String get description => _description;
  String get foodType => _foodType;
  String get image => _image;
  double get rating => _rating;
  int get price => _price;
  bool get featured => _featured;
  int get rates => _rates;

  // public variable
  bool liked = false;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _image = snapshot.data[IMAGE];
    _restaurant = snapshot.data[RESTAURANT];
    _restaurantId = snapshot.data[RESTAURANT_ID];
    _description = snapshot.data[DESCRIPTION];
    _id = snapshot.data[ID];
    _featured = snapshot.data[FEATURED];
    //_price = snapshot.data[PRICE];
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _rating = snapshot.data[RATING];
    _foodType = snapshot.data[FOOD_TYPE];
    _rates = snapshot.data[RATES];
    _name = snapshot.data[NAME];
  }
}
