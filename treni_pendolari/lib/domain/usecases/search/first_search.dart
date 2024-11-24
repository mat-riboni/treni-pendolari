import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/repositories/first_search_repository.dart';

class FirstSearchUseCase {
  FirstSearchUseCase(this.firstSearchRepository);
  final FirstSearchRepository firstSearchRepository;

  Future<List<ResponseTrip>> call() {
    return firstSearchRepository.getRoutineAndSearch();
  }
}
