import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/domain/repositories/search_repository.dart';

class SearchTripUseCase {
  SearchTripUseCase(this.searchRepository);
  final SearchRepository searchRepository;

  Future<List<ResponseTrip>> call(SearchingTrip trip) {
    return searchRepository.searchTrip(trip);
  }
}
