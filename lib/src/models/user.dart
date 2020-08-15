import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";
  static const STRIPE_ID = "stripe_id";
  static const CART = "cart";

  //static const LIKED_FOOD = "likedFood";
  //static const LIKED_RESTAURANTS = "likedRestaurants";

  String _name;
  String _id;
  String _email;
  String _stripeId;
  int _priceSum = 0;

  //public variable
  List cart;
  int totalCartPrice;

  //List _likedFood;
  //List _likedRestaurants;

  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;

  //List get likedFood => _likedFood;
  //List get likedRestaurants => _likedRestaurants;

  UserModel.fromSnapShot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _stripeId = snapshot.data[STRIPE_ID];
    cart = snapshot.data[CART] ?? [];
    totalCartPrice = getTotalPrice(cart: snapshot.data[CART]);
    //_likedFood = snapshot.data[LIKED_FOOD] ?? [];
    //_likedRestaurants = snapshot.data[LIKED_RESTAURANTS] ?? [];
  }
  int getTotalPrice({List cart}) {
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }
    return _priceSum;
  }

  // _convertCartItems(List<Map> cart) {
  //   List<CartItemModel> convertedCart = [];
  //   for (Map cartItem in cart) {
  //     convertedCart.add(CartItemModel.fromMap(cartItem));
  //   }
  //   return convertedCart;
  // }
}
