import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class CategoryServices {
  String collection = "categories";
  Firestore _firestore = Firestore.instance;

  Future<List<CategoryModel>> getCategories() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<CategoryModel> categories = [];
        for (DocumentSnapshot Category in result.documents) {
          //converting to type object so that that we can retrive field easyly
          categories.add(CategoryModel.fromSnapshot(Category));
        }
        return categories;
      });
}
