import 'package:flutter/material.dart';
import 'package:treni_pendolari/domain/entities/station/station.dart';

abstract class Stop {
  Stop(
      this.station,
      this.track,
      this.departureDelay,
      this.programmedArrivalTime,
      this.programmedDepartureTime,
      this.realArrivalTime,
      this.realDepartureTime);
  final Station station;
  final String track;
  final TimeOfDay? programmedArrivalTime;
  final TimeOfDay? programmedDepartureTime;
  final TimeOfDay? realArrivalTime;
  final TimeOfDay? realDepartureTime;
  final String departureDelay;
}
