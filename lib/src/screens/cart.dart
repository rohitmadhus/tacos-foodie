import 'package:flutter/material.dart';
import 'package:foodie/src/models/products.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/title.dart';

class ShoppoingCart extends StatefulWidget {
  @override
  _ShoppoingCartState createState() => _ShoppoingCartState();
}

class _ShoppoingCartState extends State<ShoppoingCart> {
  Product product = Product(
      name: "cereals",
      price: 5.99,
      rating: 4.2,
      wishList: true,
      image: "1.jpg",
      vendor: "good - foods",
      details: "jkdhvljkdsnvlkdnvlkdnvlkdfnvlkdfnvlkdfnvlkd");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: black), onPressed: null),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Shopping Bag"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset("assets/Images/shopping-bag.png",
                      width: 20, height: 20),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: grey, blurRadius: 3, offset: Offset(2, 1))
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 2.0, right: 4),
                        child: CustomText(
                            text: "2",
                            colors: red,
                            size: 16,
                            weight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 100,
              alignment: Alignment.centerLeft,
              // width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(color: white, boxShadow: [
                BoxShadow(
                    color: Colors.red[50], offset: Offset(3, 2), blurRadius: 5)
              ]),
              child: Row(
                children: <Widget>[
                  Image.asset("assets/Images/${product.image}",
                      height: 120, width: 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: product.name + "\n",
                            style: TextStyle(color: black, fontSize: 20)),
                        TextSpan(
                            text: "₹ " + product.price.toString() + "\n",
                            style: TextStyle(
                                color: black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold))
                      ])),
                      SizedBox(width: 100),
                      IconButton(
                          icon: Icon(Icons.delete, color: black),
                          onPressed: null)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
