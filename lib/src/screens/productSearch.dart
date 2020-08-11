import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/screens/detail.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/product.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 3,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: CustomText(text: "Products", size: 20),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: productProvider.productsSearched.length < 1
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.search, color: grey, size: 30),
                    SizedBox(height: 15),
                    CustomText(
                        text: "No Products Found",
                        colors: grey,
                        weight: FontWeight.w200,
                        size: 20)
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    changeScreen(
                        context,
                        Details(
                            product: productProvider.productsSearched[index]));
                  },
                  child: ProductWidget(
                      product: productProvider.productsSearched[index]),
                );
              }),
    );
  }
}
