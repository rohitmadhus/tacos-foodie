import 'package:flutter/material.dart';
import 'package:foodie/src/models/order.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Orders",
        ),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index) {
            OrderModel order = user.orders[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(-2, -1),
                        blurRadius: 5),
                  ]),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "₹ ${order.total}",
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    title: Text(order.description),
                    subtitle: Text(
                        DateTime.fromMillisecondsSinceEpoch(order.createdAt)
                            .toString()),
                    trailing:
                        CustomText(text: order.status, colors: Colors.green),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
