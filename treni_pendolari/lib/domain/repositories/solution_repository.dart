import 'package:treni_pendolari/domain/entities/search/solution.dart';

abstract class SolutionRepository {
  Future<List<Solution>> findSolutions(String departureLocationId,
      String arrivalLocationId, DateTime departureTime);
}
