import 'package:treni_pendolari/data/models/station/station_model.dart';
import 'package:treni_pendolari/data/sources/api/autocomplete_service.dart';
import 'package:treni_pendolari/domain/entities/station/station.dart';
import 'package:treni_pendolari/domain/repositories/autocomplete_repository.dart';

class AutocompleteRepositoryImpl implements AutocompleteRepository {
  AutocompleteRepositoryImpl(this.autocompleteService);

  final AutocompleteService autocompleteService;

  @override
  Future<List<Station>> findStationsByName(String name) async {
    try {
      List<Map<String, dynamic>> response =
          await autocompleteService.autocompleteLeFrecce(name);
      final List<Station> stations = [];
      for (final station in response) {
        stations.add(StationModel(
            name: station["name"]!,
            locationId: station["id"].toString(),
            code: ""));
      }
      return stations;
    } catch (e) {
      return Future.value([]);
    }
  }

  @override
  Future<Station> findStationByNameViaggiatreno(String name) async {
    try {
      final response = await autocompleteService.autocompleteViaggiaTreno(name);

      final lines = response.split('\n');

      if (lines.isEmpty || lines.first.isEmpty) {
        throw Exception('Input non valido o vuoto.');
      }

      final firstLine = lines.first;

      final parts = firstLine.split('|');

      if (parts.length < 2) {
        throw Exception('Formato non valido per la prima riga.');
      }
      return StationModel(
          name: parts[0].trim(), locationId: "", code: parts[1].trim());
    } catch (e) {
      return StationModel(name: "", locationId: "", code: "");
    }
  }
}
