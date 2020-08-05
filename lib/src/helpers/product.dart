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

  Future<List<ProductModel>> getProductsFromCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((result) {
        List<ProductModel> productsInCategory = [];
        for (DocumentSnapshot product in result.documents) {
          //converting to type object so that that we can retrive field easily
          productsInCategory.add(ProductModel.fromSnapshot(product));
        }
        return productsInCategory;
      });

  Future<List<ProductModel>> getProductsFromRestaurant({int id}) async =>
      _firestore
          .collection(collection)
          .where("restaurantId", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<ProductModel> productsInRestaurant = [];
        for (DocumentSnapshot product in result.documents) {
          //converting to type object so that that we can retrive field easily
          productsInRestaurant.add(ProductModel.fromSnapshot(product));
        }
        return productsInRestaurant;
      });
}
