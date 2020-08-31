import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/helpers/timeSlot.dart';
import 'package:foodie/src/models/cartItem.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/cart.dart';
import 'package:foodie/src/providers/restaurant.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/screens/order.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/checkOutDialog.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/timeSlot.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';
import 'package:foodie/src/helpers/order.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();
  var times;
  final now = TimeOfDay.now();

  void initState() {
    super.initState();
    times = getTimes().map((tod) => tod).toList();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Cart",
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: user.userModel.cart.length,
              itemBuilder: (context, index) {
                // ignore: non_constant_identifier_names
                List ShoppingCart = user.userModel.cart;

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 2, bottom: 2),
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: red.withOpacity(0.2),
                              offset: Offset(3, 2),
                              blurRadius: 30)
                        ],
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                          child: Image.network(
                            ShoppingCart[index].image,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ShoppingCart[index].name,
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹ " +
                                            ShoppingCart[index]
                                                .price
                                                .toString(),
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "Quantity : ",
                                              style: TextStyle(
                                                  color: grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400)),
                                          TextSpan(
                                              text: ShoppingCart[index]
                                                      .quantity
                                                      .toString() +
                                                  "\n",
                                              style: TextStyle(
                                                  color: red,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300)),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              app.changeLoading();

                              bool value = await user.removeFromCart(
                                  cartItem: ShoppingCart[index]);
                              if (value) {
                                user.reloadUserModel();
                                _key.currentState.showSnackBar(SnackBar(
                                    backgroundColor: grey,
                                    content: Text("Item removed")));
                                app.changeLoading();
                                return;
                              } else {
                                print("Item not removed");

                                app.changeLoading();
                              }
                            })
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        height: 183,
        child: Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Time Slot : ",
                          style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: now.hour >= 9 && now.hour <= 20
                        ? TimeSlotWidget()
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                            child: Text("No Slots available"),
                          ),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Total : ",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "₹ " +
                                  user.userModel.totalCartPrice.toString(),
                              style: TextStyle(
                                  color: black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300)),
                        ]),
                      ),
                    ],
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                        color: red, borderRadius: BorderRadius.circular(5)),
                    child: FlatButton(
                        onPressed: () {
                          if (cartProvider.timeSlot == "") {
                            cartProvider.changeTimeSlot(
                                newTimeSlot: times[0].format(context));
                          }
                          print("time : ${cartProvider.changeTimeSlot}");
                          if (user.userModel.totalCartPrice == 0) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CheckOutDialog();
                                });
                            return;
                          }
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10)), //this right here
                                  child: Container(
                                    height: 500,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 8),
                                            child: Text(
                                              "CONFIRM TO CHECKOUT",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 0),
                                              child: Text(
                                                'Total price : ₹ ${user.userModel.totalCartPrice}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 8),
                                            child: Text("(pay upon delivery)",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('Pick Up Time : ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(cartProvider.timeSlot,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: red,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          SizedBox(
                                            width: 250,
                                            child: RaisedButton(
                                              onPressed: () async {
                                                // app.changeLoading();
                                                print(user.userModel.cart[0]
                                                    .restaurantId
                                                    .toString());
                                                await restaurantProvider
                                                    .getRestaurantName(
                                                        restaurantId: user
                                                            .userModel
                                                            .cart[0]
                                                            .restaurantId
                                                            .toString());
                                                var uuid = Uuid();
                                                String id = uuid.v4();
                                                _orderServices.createOrder(
                                                    userId: user.user.uid,
                                                    id: id,
                                                    description:
                                                        (restaurantProvider
                                                                .restaurantName
                                                                .toString() +
                                                            "     ₹ :" +
                                                            user.userModel
                                                                .totalCartPrice
                                                                .toString()),
                                                    status: "pending",
                                                    cart: user.userModel.cart,
                                                    totalPrice: user.userModel
                                                        .totalCartPrice);
                                                for (CartItemModel cartItem
                                                    in user.userModel.cart) {
                                                  bool value =
                                                      await user.removeFromCart(
                                                          cartItem: cartItem);
                                                  if (value) {
                                                    user.reloadUserModel();
                                                  } else {
                                                    print("Item not removed");
                                                  }
                                                }
                                                _key.currentState.showSnackBar(
                                                    SnackBar(
                                                        backgroundColor: grey,
                                                        content: Text(
                                                            "Order Placed")));
                                                //app.changeLoading();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Confirm",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: const Color(0xFF1BC0C5),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 250,
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: CustomText(
                            text: "Check out",
                            colors: white,
                            size: 15,
                            weight: FontWeight.w800)),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.home),
                            Text(
                              "Home",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        app.changeLoading();
                        await user.getOrders();
                        changeScreen(context, OrderScreen());
                        app.changeLoading();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.date_range),
                            Text(
                              "Orders",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        app.changeLoading();
                        await user.getOrders();
                        app.changeLoading();
                        changeScreen(context, CartScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.shopping_cart),
                            Text(
                              "Cart",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.person),
                            Text(
                              "Profile",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
