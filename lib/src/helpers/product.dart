import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/src/models/products.dart';

class ProductServices {
  String collection = "products";
  Firestore _firestore = Firestore.instance;

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          //converting to type object so that that we can retrive field easyly
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });
}
