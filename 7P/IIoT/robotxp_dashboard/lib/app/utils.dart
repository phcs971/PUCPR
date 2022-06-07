import 'package:flutter/material.dart';

class RobotColors {
  RobotColors._();

  static const Color primary = Color(0xFF68B3E0);
}

DateTime dateTimeAverage(DateTime a, DateTime b) {
  final epoch = a.millisecondsSinceEpoch + b.millisecondsSinceEpoch / 2;
  return DateTime.fromMillisecondsSinceEpoch(epoch.round());
}
