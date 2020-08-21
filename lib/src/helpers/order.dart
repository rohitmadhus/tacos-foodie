import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/src/models/cartItem.dart';
import 'package:foodie/src/models/order.dart';

class OrderServices {
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  void createOrder(
      {String userId,
      String id,
      String description,
      String status,
      List cart,
      int totalPrice}) {
    List<Map> cartItems = [];
    List<String> restaurantId = [];
    for (CartItemModel item in cart) {
      cartItems.add(item.toMap());
      restaurantId.add(item.restaurantId);
    }
    _firestore.collection(collection).document(id).setData({
      "userId": userId,
      "id": id,
      "restaurantIds": restaurantId,
      "cart": cartItems,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async => _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          //converting to type object so that that we can retrive field easily
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}
