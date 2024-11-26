import 'package:treni_pendolari/domain/entities/station/station.dart';

abstract class AutocompleteRepository {
  Future<List<Station>> findStationsByName(String name);
  Future<Station> findStationByNameViaggiatreno(String name);
}
