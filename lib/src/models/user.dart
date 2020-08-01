import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";
  static const STRIPE_ID = "stripe_id";

  //static const LIKED_FOOD = "likedFood";
  //static const LIKED_RESTAURANTS = "likedRestaurants";

  String _name;
  String _id;
  String _email;
  String _stripeId;

  //List _likedFood;
  //List _likedRestaurants;

  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;
  //List get likedFood => _likedFood;
  //List get likedRestaurants => _likedRestaurants;

  UserModel.fromSnapoShot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _stripeId = snapshot.data[STRIPE_ID];
    //_likedFood = snapshot.data[LIKED_FOOD] ?? [];
    //_likedRestaurants = snapshot.data[LIKED_RESTAURANTS] ?? [];
  }
}
