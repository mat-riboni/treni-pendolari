abstract class Station {
  Station({required this.name, required this.locationId, required this.code});

  final String name;
  final String locationId;
  final String code;

  Station copyWith({String? name, String? locationId, String? code});
}
