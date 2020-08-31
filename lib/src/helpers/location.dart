import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/src/models/location.dart';

class LocationServices {
  String collection = "locations";
  Firestore _firestore = Firestore.instance;

  Future<List<LocationModel>> getLocations() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<LocationModel> locations = [];
        for (DocumentSnapshot location in result.documents) {
          //converting to type object so that that we can retrive field easyly
          locations.add(LocationModel.fromSnapshot(location));
        }
        return locations;
      });
}
