import 'package:flutter/material.dart';
import 'package:foodie/src/datatype/listItem.dart';

Iterable<TimeOfDay> getTimes() sync* {
  TimeOfDay startTime;
  final now = TimeOfDay.now();
  if (now.hour > 9 && now.hour < 20) {
    if (now.minute < 20) {
      startTime = TimeOfDay(hour: now.hour, minute: 30);
    } else if (now.minute > 50) {
      startTime = TimeOfDay(hour: now.hour + 1, minute: 30);
    } else {
      startTime = TimeOfDay(hour: now.hour + 1, minute: 0);
    }
  } else {
    startTime = TimeOfDay(hour: 23, minute: 0);
  }
  final endTime = TimeOfDay(hour: 20, minute: 0);
  final step = Duration(minutes: 30);

  var hour = startTime.hour;
  var minute = startTime.minute;

  do {
    yield TimeOfDay(hour: hour, minute: minute);
    minute += step.inMinutes;
    while (minute >= 60) {
      minute -= 60;
      hour++;
    }
  } while (hour < endTime.hour ||
      (hour == endTime.hour && minute <= endTime.minute));
}
