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
  final String departureTime;

  RoutineTrip copyWith({
    String? from,
    String? to,
    String? departureTime,
    String? fromId,
    String? toId,
    String? fromCode,
    String? toCode,
  });
}
