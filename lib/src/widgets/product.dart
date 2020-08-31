import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/models/products.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/providers/restaurant.dart';
import 'package:foodie/src/screens/restaurant.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 2, bottom: 2),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(-2, -1),
                  blurRadius: 5),
            ]),
//            height: 160,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  width: 120,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                        child: Row(
                          children: <Widget>[
                            CustomText(
                              text: "From :",
                              colors: grey,
                              weight: FontWeight.w300,
                              size: 14,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await productProvider.loadProductsByRestaurant(
                                    id: product.restaurantId);
                                await restaurantProvider.loadSingleRestaurant(
                                    restaurantId: product.restaurantId);
                                changeScreen(
                                    context,
                                    RestaurantScreen(
                                        restaurantModel:
                                            restaurantProvider.restaurant));
                              },
                              child: CustomText(
                                  text: product.restaurant,
                                  colors: red,
                                  weight: FontWeight.w600,
                                  size: 15),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 3, 0, 8),
                            child: CustomText(
                              text: "₹" + product.price.toString(),
                              weight: FontWeight.bold,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
