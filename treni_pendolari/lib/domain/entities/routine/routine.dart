import 'package:treni_pendolari/domain/entities/routine/routine_trip.dart';

abstract class Routine {
  Routine(this.daparture, this.homecoming, this.isFirstOpening,
      this.switchTripTime);

  final RoutineTrip daparture;
  final RoutineTrip homecoming;
  final String switchTripTime;
  final bool isFirstOpening;
}
