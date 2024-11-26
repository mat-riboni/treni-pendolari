import 'package:treni_pendolari/domain/entities/routine/routine_trip.dart';

class RoutineTripModel extends RoutineTrip {
  RoutineTripModel(
      {required super.from,
      required super.to,
      required super.departureTime,
      required super.fromId,
      required super.toId,
      required super.fromCode,
      required super.toCode});

  @override
  RoutineTrip copyWith(
      {String? from,
      String? to,
      String? departureTime,
      String? fromId,
      String? toId,
      String? fromCode,
      String? toCode}) {
    return RoutineTripModel(
        from: from ?? this.from,
        to: to ?? this.to,
        departureTime: departureTime ?? this.departureTime,
        fromId: fromId ?? this.fromId,
        toId: toId ?? this.toId,
        fromCode: fromCode ?? this.fromCode,
        toCode: toCode ?? this.toCode);
  }
}
