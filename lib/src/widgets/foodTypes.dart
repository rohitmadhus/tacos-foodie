import 'package:flutter/material.dart';
import 'package:foodie/src/models/foodType.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodTypes extends StatelessWidget {
  final FoodTypeModel foodType;

  const FoodTypes({Key key, this.foodType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(color: grey, offset: Offset(1, 1), blurRadius: 4)
            ]),
            child: Padding(
                padding: EdgeInsets.all(2),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.center,
                          child: Loading(),
                        )),
                        Center(
                            child: FadeInImage.memoryNetwork(
                                height: 50,
                                width: 50,
                                placeholder: kTransparentImage,
                                image: foodType.image,
                                fit: BoxFit.cover))
                      ],
                    ))),
          ),
          SizedBox(
            height: 4,
          ),
          CustomText(
            text: foodType.name,
            size: 11,
            colors: black,
          )
        ],
      ),
    );
  }
}
