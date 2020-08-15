import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/user.dart';
import 'package:foodie/src/helpers/order.dart';
import 'package:foodie/src/models/order.dart';
import 'package:foodie/src/models/products.dart';
import 'package:foodie/src/models/user.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Unauthenticated, Authenticating, Authenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

  //getters
  //to get values outside of the class but not modifiable
  Status get status => _status;
  FirebaseUser get user => _user;
  UserModel get userModel => _userModel;

  //Public variable
  List<OrderModel> orders = [];

  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      return _onError(e);
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((user) {
        Map<String, dynamic> values = {
          "name": name.text,
          "email": email.text,
          "id": user.user.uid,
          "likedFood": [],
          "likedRestaurants": []
        };
        _userServices.createUser(values);
      });
      return true;
    } catch (e) {
      return _onError(e);
    }
  }

  Future signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
    }
    notifyListeners();
  }

  bool _onError(Error error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print("error" + error.toString());
    return false;
  }

  void cleanContainer() {
    email.text = "";
    password.text = "";
    name.text = "";
  }

  Future<bool> addToCart({ProductModel product, int quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v1();
      //List cart = _userModel.cart;
      // bool itemExist = false;
      // bool diffRestaurant = false;
      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity,
        "restaurantId": product.restaurantId
      };
      // for (Map item in cart) {
      //   if (item["restaurantId"] != cartItem["restaurantId"]) {
      //     diffRestaurant = true;
      //   }
      // }
      //   if (item["productId"] == cartItem["productId"]) {
      //     item["quantity"] = item["quantity"] + quantity;
      //     itemExist = true;
      //     break;
      //   }
      // }
      // if (!itemExist) {
      //   _userModel.cart.add(cartItem);
      // }
      _userModel.cart.add(cartItem);
      _userServices.addToCart(cartItem: cartItem, uId: _userModel.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromCart({Map cartItem}) async {
    try {
      _userServices.removeFromCart(cartItem: cartItem, uId: _userModel.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
}
