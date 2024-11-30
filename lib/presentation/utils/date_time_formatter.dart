import 'package:flutter/material.dart';

class DateTimeFormatter {
  static String dateTimeToString(DateTime dt) {
    String date;
    if (dt.day == DateTime.now().day) {
      date = "Oggi";
    } else {
      date = "${dt.day}/${dt.month}/${dt.year}";
    }

    if (dt.minute <= 9) {
      return "$date - ${dt.hour}:0${dt.minute}";
    }
    return "$date - ${dt.hour}:${dt.minute}";
  }

  static int dateTimeStringToMills(String date) {
    DateTime dateTimeFormat = DateTime.parse(date);
    return dateTimeFormat.millisecondsSinceEpoch;
  }

  static int dateTimeToMills(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  static TimeOfDay dateTimeStringToTimeOfDay(String date) {
    DateTime dateTime = DateTime.parse(date);

    int hours = dateTime.hour;
    int minutes = dateTime.minute;

    return TimeOfDay(hour: hours, minute: minutes);
  }

  static TimeOfDay millsToTimeOfDay(int mills) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(mills);

    int hour = dateTime.hour;
    int minute = dateTime.minute;

    return TimeOfDay(hour: hour, minute: minute);
  }

  static String timeOfDayToString(TimeOfDay time) {
    String hour = time.hour.toString();
    String minutes = time.minute.toString();
    if (time.hour <= 9) hour = "0${time.hour}";
    if (time.minute <= 9) minutes = "0${time.minute}";

    return "$hour:$minutes";
  }

  static stringToTimeOfDay(String time) {
    if (time.isEmpty) return const TimeOfDay(hour: 00, minute: 00);
    final parts = time.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  static bool isDelayPositive(String delay) {
    try {
      int delayNum = int.parse(delay);
      if (delayNum > 0) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  static bool isDelayPositiveOrZero(String delay) {
    try {
      int delayNum = int.parse(delay);
      if (delayNum >= 0) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  static TimeOfDay timeInMiddle(TimeOfDay start, TimeOfDay end) {
    int startMinutes = start.hour * 60 + start.minute;
    int endMinutes = end.hour * 60 + end.minute;

    int midpointMinutes = (startMinutes + endMinutes) ~/ 2;

    int hour = midpointMinutes ~/ 60;
    int minute = midpointMinutes % 60;

    return TimeOfDay(hour: hour, minute: minute);
  }

  static bool isTimeAfterNow(TimeOfDay time) {
    final now = TimeOfDay.now();

    final nowDateTime = DateTime.now();
    final dateTime = DateTime(nowDateTime.year, nowDateTime.month,
        nowDateTime.day, time.hour, time.minute);
    final currentDateTime = DateTime(nowDateTime.year, nowDateTime.month,
        nowDateTime.day, now.hour, now.minute);

    return dateTime.isAfter(currentDateTime);
  }
}
