import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/models/products.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/screens/cart.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../style.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  final _key = GlobalKey<ScaffoldState>();

  TabController _tabController;
  int quantity = 1;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

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
              backgroundColor: Colors.white,
              toolbarHeight: 90,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.pop(context);
                    changeScreen(context, CartScreen());
                  },
                ),
              ],
              leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              bottom: TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Colors.red,
                tabs: [
                  new Container(
                    height: 40,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.fastfood, size: 18),
                        Text("Product")
                      ],
                    ),
                  ),
                  new Container(
                    height: 40,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.rate_review, size: 18),
                        Text("Reviews")
                      ],
                    ),
                  ),
                ],
                controller: _tabController,
                indicatorColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(fontSize: 12),
              ),
            ),
            backgroundColor: white,
            body: TabBarView(
              children: [
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: widget.product.image,
                              height: 160,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      CustomText(
                          text: widget.product.name,
                          size: 20,
                          weight: FontWeight.bold),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                          text: "₹ ${widget.product.price}",
                          size: 18,
                          weight: FontWeight.w400),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    size: 20,
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
                                int value = await user.addToCart(
                                    product: widget.product,
                                    quantity: quantity);
                                if (value == 1) {
                                  _key.currentState.showSnackBar(SnackBar(
                                      backgroundColor: grey,
                                      content: Text("Item added to cart")));
                                  await user.reloadUserModel();
                                  app.changeLoading();
                                  return;
                                } else {
                                  if (value == 2) {
                                    _key.currentState.showSnackBar(SnackBar(
                                        backgroundColor: grey,
                                        content: Text(
                                          "You cannot add products from different restaurants to cart",
                                          textAlign: TextAlign.center,
                                        )));
                                  }
                                  app.changeLoading();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: red,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                  child: CustomText(
                                    text: "Add $quantity To Cart",
                                    colors: white,
                                    size: 13,
                                    weight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: 20,
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                          text: "Description",
                          size: 15,
                          weight: FontWeight.w400),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          widget.product.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: grey, fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(height: 15)
                    ],
                  ),
                ),
                new Text("This is chat Tab View"),
              ],
              controller: _tabController,
            ),
          );
  }
}
