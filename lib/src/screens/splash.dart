import 'package:flutter/material.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/title.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/Images/meat.jpeg",
                  fit: BoxFit.cover,
                  height: 100,
                  width: 200,
                )),
            SizedBox(height: 20),
            //CustomText(text: "Loading"),
            SizedBox(height: 20),
            Loading(),
          ],
        ));
  }
}
