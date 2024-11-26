import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';

abstract class SearchRepository {
  Future<List<ResponseTrip>> searchTrip(SearchingTrip trip);
}
