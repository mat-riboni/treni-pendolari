abstract class RoutineTrip {
  RoutineTrip(
      {required this.from,
      required this.to,
      required this.departureTime,
      required this.fromId,
      required this.toId});

  final String from;
  final String fromId;
  final String to;
  final String toId;
  final String departureTime;

  RoutineTrip copyWith(
      {String? from,
      String? to,
      String? departureTime,
      String? fromId,
      String? toId});
}
