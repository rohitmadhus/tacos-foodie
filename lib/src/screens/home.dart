import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/foodType.dart';
import 'package:foodie/src/providers/location.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/providers/restaurant.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/providers/category.dart';
import 'package:foodie/src/screens/cart.dart';
import 'package:foodie/src/screens/category.dart';
import 'package:foodie/src/screens/foodType.dart';
import 'package:foodie/src/screens/locationSearch.dart';
import 'package:foodie/src/screens/order.dart';
import 'package:foodie/src/screens/productSearch.dart';
import 'package:foodie/src/screens/restaurant.dart';
import 'package:foodie/src/screens/restaurantSearch.dart';
import 'package:foodie/src/screens/seeAllRestaurant.dart';
import 'package:foodie/src/widgets/category.dart';
import 'package:foodie/src/widgets/foodTypes.dart';
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
    final foodTypeProvider = Provider.of<FoodTypeProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        iconTheme: IconThemeData(color: black),
        elevation: 0,
        toolbarHeight: 45,
        title: CustomText(text: "TACOS"),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, size: 15),
                  Container(
                    width: 100,
                    height: 40,
                    color: white,
                    child: Row(
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            changeScreen(context, LocationSearchScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                locationProvider.userLocation.name,
                                style: TextStyle(fontSize: 12, color: black),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                  child: user.userModel.cart == null ||
                          user.userModel.cart.length <= 0
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
              //key: PageStorageKey<String>('homePageController'),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: grey,
                                  offset: Offset(1, 1),
                                  blurRadius: 2)
                            ]),
                        child: ListTile(
                          leading: Icon(Icons.search, color: red, size: 20),
                          focusColor: Colors.red[50],
                          title: TextField(
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (pattern) async {
                              app.changeLoading();
                              if (app.search == SearchBy.PRODUCTS) {
                                changeScreen(context, ProductSearchScreen());
                                await productProvider.searchedProducts(
                                    productName: pattern);
                              }
                              if (app.search == SearchBy.RESTAURANTS) {
                                changeScreen(context, RestaurantSearchScreen());
                                await restaurantProvider.searchedRestaurants(
                                    restaurantName: pattern);
                              }
                              app.changeLoading();
                            },
                            decoration: InputDecoration(
                                hintText: "Find your foods and Restaurants",
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: CustomText(
                          text: "Search By :", colors: Colors.black, size: 12),
                    ),
                    DropdownButton<String>(
                        dropdownColor: white,
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w300,
                            fontSize: 12),
                        value: app.filterBy,
                        items: <String>["Restaurants", "Products"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        icon: Icon(Icons.filter_list, color: red, size: 15),
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
                // Divider(),

                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryProvider.categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                app.changeLoading();
                                changeScreen(
                                    context,
                                    CategoryScreen(
                                        categoryModel: categoryProvider
                                            .categories[index]));
                                await productProvider.loadProductsByCategory(
                                    categoryName: categoryProvider
                                        .categories[index].name);
                                app.changeLoading();
                              },
                              child: CategoryWidget(
                                  categoryModel:
                                      categoryProvider.categories[index]),
                            );
                          })),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      height: 85,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: foodTypeProvider.foodTypes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () async {
                                  app.changeLoading();
                                  changeScreen(
                                      context,
                                      FoodTypeScreen(
                                          foodTypeModel: foodTypeProvider
                                              .foodTypes[index]));
                                  await productProvider.loadProductsByFoodType(
                                      foodType: foodTypeProvider
                                          .foodTypes[index].name);
                                  app.changeLoading();
                                },
                                child: FoodTypes(
                                    foodType:
                                        foodTypeProvider.foodTypes[index]));
                          })),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CustomText(
                          text: "Featured",
                          size: 15,
                          colors: grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                          text: "see all",
                          size: 12,
                          colors: red,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Featured(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomText(
                          text: "Popular restaurants",
                          size: 15,
                          colors: grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          changeScreen(context, SeeAllRestaurantScreen());
                          app.changeLoading();
                          await restaurantProvider.loadRestaurants();

                          app.changeLoading();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: CustomText(
                            text: "see all",
                            size: 12,
                            colors: red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 3, 10, 5),
                  child: Column(
                    children: restaurantProvider.popularRestaurants
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
      bottomNavigationBar: Container(
        height: 55,
        color: white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.home),
                        Text(
                          "Home",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    app.changeLoading();
                    changeScreen(context, OrderScreen());
                    await user.getOrders();
                    app.changeLoading();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        Text(
                          "Orders",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    app.changeLoading();
                    changeScreen(context, CartScreen());
                    await user.getOrders();
                    app.changeLoading();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text(
                          "Cart",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.person),
                        Text(
                          "Profile",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
