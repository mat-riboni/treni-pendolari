import 'package:flutter/material.dart';

abstract class RoutineTrip {
  RoutineTrip({
    required this.from,
    required this.to,
    required this.departureTime,
    required this.fromId,
    required this.toId,
    required this.fromCode,
    required this.toCode,
  });

  final String from;
  final String fromId;
  final String fromCode;
  final String to;
  final String toId;
  final String toCode;
  final TimeOfDay departureTime;

  RoutineTrip copyWith({
    String? from,
    String? to,
    TimeOfDay? departureTime,
    String? fromId,
    String? toId,
    String? fromCode,
    String? toCode,
  });
}
