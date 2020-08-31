import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/models/foodType.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/product.dart';
import 'package:foodie/src/screens/detail.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/product.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodTypeScreen extends StatelessWidget {
  final FoodTypeModel foodTypeModel;

  const FoodTypeScreen({Key key, this.foodTypeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      body: app.isLoading
          ? Loading()
          : SafeArea(
              child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      )),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: foodTypeModel.image,
                          height: 160,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
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
                                text: foodTypeModel.name,
                                colors: Colors.white,
                                size: 26,
                                weight: FontWeight.w300,
                              ))),
                      Positioned.fill(
                          top: 5,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: black.withOpacity(0.3)),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: productProvider.productsByFoodType
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
