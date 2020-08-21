import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/src/models/cartItem.dart';
import 'package:foodie/src/models/user.dart';

class UserServices {
  String userCollection = "users";
  Firestore _firestore = Firestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];

    _firestore.collection(userCollection).document(id).setData(values);
  }

  void updateUserData(Map<String, dynamic> values) {
    _firestore
        .collection(userCollection)
        .document(values["id"])
        .updateData(values);
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(userCollection).document(id).get().then((doc) {
        return UserModel.fromSnapShot(doc);
      });

  void addToCart({String uId, CartItemModel cartItem}) {
    _firestore.collection(userCollection).document(uId).updateData({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String uId, CartItemModel cartItem}) {
    _firestore.collection(userCollection).document(uId).updateData({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}
