import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/models/category.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/screens/detail.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/product.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../style.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryScreen({Key key, this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: Loading(),
              )),
              ClipRRect(
//                borderRadius: BorderRadius.only(
//                  bottomLeft: Radius.circular(30),
//                  bottomRight: Radius.circular(30),
//                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: categoryModel.image,
                  height: 160,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Container(
                height: 160,
                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.only(
//                      bottomLeft: Radius.circular(30),
//                      bottomRight: Radius.circular(30),
//                    ),
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.025),
                  ],
                )),
              ),
              Positioned.fill(
                  bottom: 40,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomText(
                        text: categoryModel.name,
                        colors: Colors.white,
                        size: 26,
                        weight: FontWeight.w300,
                      ))),
              Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: black.withOpacity(0.2)),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: productProvider.productsByCategory
                .map((item) => GestureDetector(
                      onTap: () {
                        changeScreen(context, Details(product: item));
                      },
                      child: ProductWidget(product: item),
                    ))
                .toList(),
          )
        ],
      )),
    );
  }
}
