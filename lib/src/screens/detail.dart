import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/models/products.dart';
import 'package:foodie/src/widgets/title.dart';

class Details extends StatefulWidget {
  final Product product;
  Details({@required this.product});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: Stack(
                children: <Widget>[
                  Carousel(
                    images: [
                      AssetImage('assets/Images/${widget.product.image}'),
                      AssetImage('assets/Images/${widget.product.image}'),
                      AssetImage('assets/Images/${widget.product.image}'),
                      AssetImage('assets/Images/${widget.product.image}')
                    ],
                    dotBgColor: white,
                    dotColor: grey,
                    dotIncreasedColor: red,
                    dotIncreaseSize: 1.2,
                    autoplay: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: black),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset("assets/Images/shopping-bag.png",
                                      width: 30, height: 30)
                                ],
                              ),
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
                                          color: grey,
                                          blurRadius: 3,
                                          offset: Offset(2, 1))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, right: 4),
                                  child: CustomText(
                                      text: "2",
                                      colors: red,
                                      size: 18,
                                      weight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    bottom: 55,
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey, offset: Offset(2, 3), blurRadius: 3)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(Icons.favorite, size: 22, color: red),
                      ),
                    ),
                  )
                ],
              ),
            ),
            CustomText(
                text: widget.product.name, size: 26, weight: FontWeight.bold),
            CustomText(
                text: "Rs" + widget.product.price.toString(),
                size: 20,
                colors: red,
                weight: FontWeight.w400),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(Icons.remove, size: 28, color: red),
                      onPressed: () {}),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(color: red),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      child: CustomText(
                          text: "Add To Bag",
                          colors: white,
                          size: 22,
                          weight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(Icons.add, size: 28, color: red),
                      onPressed: () {}),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
