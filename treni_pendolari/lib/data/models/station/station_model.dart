import 'package:treni_pendolari/domain/entities/station/station.dart';

class StationModel extends Station {
  StationModel(
      {required super.name, required super.locationId, required super.code});

  @override
  Station copyWith({String? name, String? locationId, String? code}) {
    return StationModel(
        name: name ?? this.name,
        locationId: locationId ?? this.locationId,
        code: code ?? this.code);
  }
}
