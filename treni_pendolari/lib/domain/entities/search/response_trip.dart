import 'package:flutter/material.dart';
import 'package:treni_pendolari/domain/entities/station/node.dart';
import 'package:treni_pendolari/domain/entities/station/station.dart';

abstract class ResponseTrip {
  ResponseTrip(
      {required this.from,
      required this.to,
      required this.departureTime,
      required this.arrivalTime,
      required this.delay,
      required this.duration,
      required this.departureTrack,
      required this.nodes});
  final Station from;
  final Station to;
  final TimeOfDay departureTime;
  final TimeOfDay arrivalTime;
  final String delay;
  final String duration;
  final String departureTrack;
  final List<Node> nodes;
}
