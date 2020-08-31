import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  static const ID = "id";
  static const NAME = "name";
  static const LOCATION = "Location";

  String _id;
  String _name;
  GeoPoint _location;

  //  getters
  String get id => _id;
  String get name => _name;
  GeoPoint get location => _location;

  LocationModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _location = snapshot.data[LOCATION];
  }
}
