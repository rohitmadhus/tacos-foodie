import 'package:flutter/material.dart';
import 'package:foodie/src/widgets/title.dart';

class BottomNavIcon extends StatelessWidget {
  final String image;
  final String name;
  final Function onClick;

  const BottomNavIcon({Key key, this.image, this.name, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
      child: GestureDetector(
        onTap: onClick ?? null,
        child: Column(
          children: <Widget>[
            Image.asset("assets/Images/$image", width: 20, height: 20),
            SizedBox(height: 2),
            CustomText(text: name, size: 13)
          ],
        ),
      ),
    );
  }
}
