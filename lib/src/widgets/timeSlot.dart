import 'package:flutter/material.dart';
import 'package:foodie/src/helpers/timeSlot.dart';
import 'package:foodie/src/providers/cart.dart';
import 'package:foodie/src/style.dart';
import 'package:provider/provider.dart';

class TimeSlotWidget extends StatefulWidget {
  @override
  _TimeSlotWidgetState createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  List<Color> _selection = [];
  List times = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    times = getTimes().map((tod) => tod).toList();
    if (times.length > 0) {
      _selection = List.generate(times.length, (_) => Colors.red[200]);
      _selection[0] = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width - 110,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: times
              .map((e) => Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: RaisedButton(
                        textColor: white,
                        color: _selection[times.indexOf(e)],
                        onPressed: () async {
                          for (int i = 0; i < _selection.length; i++) {
                            _selection[i] = Colors.red[200];
                          }
                          cartProvider.changeTimeSlot(
                              newTimeSlot: e.format(context));
                          setState(() {
                            _selection[times.indexOf(e)] = Colors.red;
                          });
                          print(cartProvider.timeSlot);
                        },
                        child: Text(e.format(context))),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
