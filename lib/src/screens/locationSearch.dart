import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/screen_navigation.dart';
import 'package:foodie/src/providers/app.dart';
import 'package:foodie/src/providers/location.dart';
import 'package:foodie/src/providers/userAuth.dart';
import 'package:foodie/src/style.dart';
import 'package:foodie/src/widgets/loading.dart';
import 'package:foodie/src/widgets/title.dart';
import 'package:provider/provider.dart';

class LocationSearchScreen extends StatefulWidget {
  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
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
              itemCount: locationProvider.locations.length,
              itemBuilder: (context, index) {
                // ignore: non_constant_identifier_names
                return GestureDetector(
                  onTap: () {
                    locationProvider.changeLcation(
                        newLocation: locationProvider.locations[index]);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 1, bottom: 1),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            BoxShadow(
                                color: red.withOpacity(0.2),
                                offset: Offset(2, 1),
                                blurRadius: 20)
                          ],
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: Icon(Icons.my_location, size: 13),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: Text(locationProvider.locations[index].name),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
