import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/screens/detail.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/models/products.dart';
import 'package:foodie/src/widgets/title.dart';

List<ProductModel> productsList = [];

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Container(
        height: 240,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productsList.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 6, 12),
                child: GestureDetector(
                  onTap: () {
                    changeScreen(_, Details(product: productsList[index]));
                  },
                  child: Container(
                    height: 240,
                    width: 200,
                    decoration: BoxDecoration(color: white, boxShadow: [
                      BoxShadow(
                          color: grey, offset: Offset(15, 5), blurRadius: 30)
                    ]),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                            "assets/Images/${productsList[index].image}",
                            height: 140,
                            width: 140),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(text: productsList[index].name),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: grey,
                                          offset: Offset(1, 1),
                                          blurRadius: 4),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  // child: productsList[index].wishList
                                  //     ? Icon(
                                  //         Icons.favorite,
                                  //         color: red,
                                  //         size: 18,
                                  //       )
                                  //     : Icon(
                                  //         Icons.favorite_border,
                                  //         color: red,
                                  //         size: 18,
                                  //       ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CustomText(
                                      text:
                                          productsList[index].rating.toString(),
                                      colors: grey,
                                      size: 14),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(Icons.star, color: red, size: 16),
                                Icon(Icons.star, color: red, size: 16),
                                Icon(Icons.star, color: red, size: 16),
                                Icon(Icons.star, color: red, size: 16),
                                Icon(Icons.star, color: grey, size: 16)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CustomText(
                                  text: "₹ ${productsList[index].price}"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
