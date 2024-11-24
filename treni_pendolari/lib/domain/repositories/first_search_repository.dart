import 'package:treni_pendolari/domain/entities/search/response_trip.dart';

abstract class FirstSearchRepository {
  Future<List<ResponseTrip>> getRoutineAndSearch();
}
