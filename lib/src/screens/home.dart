import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/screens/cart.dart';
import 'package:foodie/src/widgets/bottom_navigation_icons.dart';
import 'package:foodie/src/widgets/categories.dart';
import 'package:foodie/src/widgets/featured_product.dart';
import 'package:foodie/src/widgets/small_floating_button.dart';
import 'package:foodie/src/widgets/title.dart';
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
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "What would you like to eat",
                      style: TextStyle(fontSize: 20),
                    )),
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
                            color: red,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                )
              ]),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(color: grey, offset: Offset(1, 1), blurRadius: 4)
            ]),
            child: ListTile(
              leading: Icon(Icons.search, color: red),
              title: TextField(
                decoration: InputDecoration(
                    hintText: "Find food and Restaurant",
                    border: InputBorder.none),
              ),
              trailing: Icon(Icons.filter_list, color: red),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Categories(),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              text: "Featured Food",
              size: 20,
              colors: grey,
            ),
          ),
          Featured(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              text: "Popular product",
              size: 20,
              colors: grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/Images/food.jpg")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SmallButton(Icons.favorite),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                              ),
                              Text("4.5")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.05),
                              Colors.black.withOpacity(0.1)
                            ])),
                  ),
                )),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Pan Cakes \n",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: white)),
                          TextSpan(
                              text: "by",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: white)),
                          TextSpan(
                              text: "Pan Cakes \n",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: white)),
                        ], style: TextStyle(color: black))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                                text: "\n 12 \n",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: white)),
                          ],
                          style: TextStyle(color: black),
                        )),
                      )
                    ],
                  ),
                ))
              ],
            ),
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
              BottomNavIcon(name: "Near by", image: "target.png"),
              BottomNavIcon(
                name: "Cart",
                image: "shopping-bag.png",
                onClick: () {
                  changeScreen(context, ShoppoingCart());
                },
              ),
              BottomNavIcon(name: "Account", image: "avatar.png")
            ]),
      ),
    );
  }
}
