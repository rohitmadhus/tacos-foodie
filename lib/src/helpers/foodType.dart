import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/src/models/foodType.dart';

class FoodTypeServices {
  String collection = "foodtypes";
  Firestore _firestore = Firestore.instance;

  Future<List<FoodTypeModel>> getFoodTypes() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<FoodTypeModel> foodTypes = [];
        for (DocumentSnapshot foodType in result.documents) {
          //converting to type object so that that we can retrive field easyly
          foodTypes.add(FoodTypeModel.fromSnapshot(foodType));
        }
        return foodTypes;
      });
}
