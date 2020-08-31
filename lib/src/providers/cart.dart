import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  String timeSlot = "";

  void changeTimeSlot({String newTimeSlot}) {
    timeSlot = newTimeSlot;
    notifyListeners();
  }
}
