import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/providers/restaurant.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/screens/cart.dart';
import 'package:foodie/src/screens/restaurant.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/restaurant.dart';
import 'package:provider/provider.dart';

class SeeAllRestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);

    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        toolbarHeight: 45,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    changeScreen(context, CartScreen());
                  },
                ),
                Positioned(
                  top: 10,
                  right: 12,
                  child: user.userModel.cart.length <= 0 ||
                          user.userModel.cart == null
                      ? Container()
                      : Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: red,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
      body: app.isLoading
          ? Loading()
          : SafeArea(
              child: ListView(
              key: PageStorageKey<String>('seeAllRestaurantPageController'),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
                  child: Column(
                    children: restaurantProvider.restaurants
                        .map((item) => GestureDetector(
                              onTap: () async {
                                app.changeLoading();
                                changeScreen(context,
                                    RestaurantScreen(restaurantModel: item));

                                await productProvider.loadProductsByRestaurant(
                                    id: item.id);
                                app.changeLoading();
                              },
                              child: RestaurantWidget(
                                restaurant: item,
                              ),
                            ))
                        .toList(),
                  ),
                )
              ],
            )),
    );
  }
}
