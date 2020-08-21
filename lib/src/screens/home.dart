import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/providers/restaurant.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/providers/category.dart';
import 'package:foodie/src/screens/cart.dart';
import 'package:foodie/src/screens/category.dart';
import 'package:foodie/src/screens/order.dart';
import 'package:foodie/src/screens/productSearch.dart';
import 'package:foodie/src/screens/restaurant.dart';
import 'package:foodie/src/screens/restaurantSearch.dart';
import 'package:foodie/src/widgets/bottom_navigation_icons.dart';
import 'package:foodie/src/widgets/category.dart';
import 'package:foodie/src/widgets/food_types.dart';
import 'package:foodie/src/widgets/featured_product.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/restaurant.dart';

import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';
import '../style.dart';

/*
** @author
** Rohit Madhu
*/

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        iconTheme: IconThemeData(color: red),
        elevation: 0.7,
        title: CustomText(text: "TACOS"),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, CartScreen());
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: red, borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: red, borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                accountName: CustomText(
                  text: user.userModel?.name ?? "User name is Loading....",
                  colors: white,
                  weight: FontWeight.bold,
                  size: 18,
                ),
                accountEmail: CustomText(
                  text: user.userModel?.email ?? "Email is Loading....",
                  colors: white,
                )),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.fastfood),
              title: CustomText(text: "Food I like"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.restaurant),
              title: CustomText(text: "Liked restaurants"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, OrderScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: CustomText(text: "Settings"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : SafeArea(
              child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: Offset(1, 1),
                                blurRadius: 4)
                          ]),
                      child: ListTile(
                        leading: Icon(Icons.search, color: red),
                        title: TextField(
                          textInputAction: TextInputAction.search,
                          onSubmitted: (pattern) async {
                            app.changeLoading();
                            if (app.search == SearchBy.PRODUCTS) {
                              await productProvider.searchedProducts(
                                  productName: pattern);
                              changeScreen(context, ProductSearchScreen());
                            }
                            if (app.search == SearchBy.RESTAURANTS) {
                              await restaurantProvider.searchedRestaurants(
                                  restaurantName: pattern);
                              changeScreen(context, RestaurantSearchScreen());
                            }
                            app.changeLoading();
                          },
                          decoration: InputDecoration(
                              hintText: "Find food and Restaurant",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(text: "Search By :", colors: grey),
                    DropdownButton<String>(
                        style: TextStyle(
                          color: grey,
                          fontWeight: FontWeight.w300,
                        ),
                        value: app.filterBy,
                        items: <String>["Products", "Restaurants"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        icon: Icon(Icons.filter_list, color: red),
                        elevation: 0,
                        onChanged: (value) {
                          if (value == "Products") {
                            app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                          }
                          if (value == "Restaurants") {
                            app.changeSearchBy(
                                newSearchBy: SearchBy.RESTAURANTS);
                          }
                        }),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 5,
                ),
                FoodTypes(),
                Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              // app.changeLoading();
                              await productProvider.loadProductsByCategory(
                                  categoryName:
                                      categoryProvider.categories[index].name);
                              //  app.changeLoading();
                              changeScreen(
                                  context,
                                  CategoryScreen(
                                      categoryModel:
                                          categoryProvider.categories[index]));
                            },
                            child: CategoryWidget(
                                categoryModel:
                                    categoryProvider.categories[index]),
                          );
                        })),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CustomText(
                          text: "Featured",
                          size: 20,
                          colors: grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                          text: "see all",
                          size: 14,
                          colors: red,
                        ),
                      ),
                    ],
                  ),
                ),
                Featured(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                          text: "Popular restaurants",
                          size: 20,
                          colors: grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                          text: "see all",
                          size: 14,
                          colors: red,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: restaurantProvider.restaurants
                      .map((item) => GestureDetector(
                            onTap: () async {
                              app.changeLoading();
                              await productProvider.loadProductsByRestaurant(
                                  id: item.id);
                              app.changeLoading();
                              changeScreen(context,
                                  RestaurantScreen(restaurantModel: item));
                            },
                            child: RestaurantWidget(
                              restaurant: item,
                            ),
                          ))
                      .toList(),
                )
              ],
            )),
      bottomNavigationBar: Container(
        height: 60,
        color: white,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BottomNavIcon(name: "home", image: "home.png"),
              BottomNavIcon(
                  name: "Orders",
                  image: "target.png",
                  onClick: () async {
                    await user.getOrders();
                    changeScreen(context, OrderScreen());
                  }),
              BottomNavIcon(
                name: "Cart",
                image: "shopping-bag.png",
                onClick: () {
                  changeScreen(context, CartScreen());
                },
              ),
              BottomNavIcon(name: "Account", image: "avatar.png")
            ]),
      ),
    );
  }
}
