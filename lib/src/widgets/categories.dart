import 'package:flutter/material.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:foodie/src/models/category.dart';

List<Category> categoriesList = [
  Category(name: "salad", image: "salad.png"),
  Category(name: "salad", image: "ice-cream.png"),
  Category(name: "salad", image: "salad.png"),
  Category(name: "salad", image: "salad.png"),
];

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 95,
        child: ListView.builder(
          itemCount: categoriesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: white, boxShadow: [
                      BoxShadow(
                          color: Colors.red[50],
                          offset: Offset(1, 1),
                          blurRadius: 4)
                    ]),
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Image.asset(
                          "assets/Images/${categoriesList[index].image}",
                          width: 50,
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: categoriesList[index].name,
                    size: 14,
                    colors: grey,
                  )
                ],
              ),
            );
          },
        ));
  }
}
