import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/src/models/restaurant.dart';

class RestaurantServices {
  String collection = "restaurants";
  Firestore _firestore = Firestore.instance;

  Future<List<RestaurantModel>> getRestaurants() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<RestaurantModel> restaurants = [];
        for (DocumentSnapshot restaurant in result.documents) {
          //converting to type object so that that we can retrive field easyly
          restaurants.add(RestaurantModel.fromSnapshot(restaurant));
        }
        return restaurants;
      });
}
