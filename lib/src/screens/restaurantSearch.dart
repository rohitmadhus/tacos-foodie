import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/providers/restaurant.dart';
import 'package:foodie/src/screens/restaurant.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/restaurant.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';

class RestaurantSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return app.isLoading
        ? Scaffold(
            backgroundColor: white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Loading()],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: black),
              backgroundColor: white,
              elevation: 3,
              leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: CustomText(text: "Restaurants", size: 20),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
              ],
            ),
            body: restaurantProvider.restaurantsSearched.length < 1
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.search, color: grey, size: 30),
                          SizedBox(height: 15),
                          CustomText(
                              text: "No Restaurant Found",
                              colors: grey,
                              weight: FontWeight.w200,
                              size: 20)
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: restaurantProvider.restaurantsSearched.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          //  app.changeLoading();
                          await productProvider.loadProductsByRestaurant(
                              id: restaurantProvider
                                  .restaurantsSearched[index].id);
                          changeScreen(
                              context,
                              RestaurantScreen(
                                  restaurantModel: restaurantProvider
                                      .restaurantsSearched[index]));
                          //  app.changeLoading();
                        },
                        child: RestaurantWidget(
                            restaurant:
                                restaurantProvider.restaurantsSearched[index]),
                      );
                    }),
          );
  }
}
