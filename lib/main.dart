import 'package:flutter/material.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/cart.dart';
import 'package:foodie/src/providers/category.dart';
import 'package:foodie/src/providers/foodType.dart';
import 'package:foodie/src/providers/location.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/providers/restaurant.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/screens/home.dart';
//import 'package:foodie/src/screens/home.dart';
import 'package:foodie/src/screens/login.dart';
import 'package:foodie/src/screens/splash.dart';
import 'package:provider/provider.dart';

/*
** @author
** Rohit Madhu
*/

void main() {
  //To avoid white screen during opening
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: FoodTypeProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: LocationProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return SplashScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Food App ",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
