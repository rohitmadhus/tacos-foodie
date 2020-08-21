import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/models/products.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/screens/cart.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _key = GlobalKey<ScaffoldState>();
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return app.isLoading
        ? Loading()
        : Scaffold(
            key: _key,
            appBar: AppBar(
              iconTheme: IconThemeData(color: black),
              backgroundColor: white,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    changeScreen(context, CartScreen());
                  },
                ),
              ],
              leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              // bottom: TabBar(
              //   unselectedLabelColor: Colors.white,
              //   labelColor: Colors.amber,
              //   tabs: [
              //     new Tab(icon: new Icon(Icons.fastfood)),
              //     new Tab(
              //       icon: new Icon(Icons.shopping_cart),
              //     ),
              //     new Tab(
              //       icon: new Icon(Icons.notifications),
              //     )
              //   ],
              //   controller: _tabController,
              //   indicatorColor: Colors.white,
              //   indicatorSize: TabBarIndicatorSize.tab,
              // ),
            ),
            backgroundColor: white,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(widget.product.image),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      text: widget.product.name,
                      size: 26,
                      weight: FontWeight.bold),
                  CustomText(
                      text: "₹${widget.product.price}",
                      size: 20,
                      weight: FontWeight.w400),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text: "Description", size: 18, weight: FontWeight.w400),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.description,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: grey, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 36,
                            ),
                            onPressed: () {
                              if (quantity != 1) {
                                setState(() {
                                  quantity -= 1;
                                });
                              }
                            }),
                      ),
                      GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          bool value = await user.addToCart(
                              product: widget.product, quantity: quantity);
                          if (value) {
                            _key.currentState.showSnackBar(SnackBar(
                                backgroundColor: grey,
                                content: Text("Item added to cart")));
                            user.reloadUserModel();
                            app.changeLoading();
                            return;
                          } else {
                            app.changeLoading();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                            child: CustomText(
                              text: "Add $quantity To Cart",
                              colors: white,
                              size: 22,
                              weight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 36,
                              color: red,
                            ),
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
