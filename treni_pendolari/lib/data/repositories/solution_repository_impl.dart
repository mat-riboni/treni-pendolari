import 'package:treni_pendolari/data/models/search/solution_model.dart';
import 'package:treni_pendolari/data/sources/api/find_solutions_service.dart';
import 'package:treni_pendolari/domain/entities/search/solution.dart';
import 'package:treni_pendolari/domain/repositories/autocomplete_repository.dart';
import 'package:treni_pendolari/domain/repositories/solution_repository.dart';

class SolutionRepositoryImpl implements SolutionRepository {
  SolutionRepositoryImpl(
    this.findSolutionsService,
    this.autocompleteRepository,
  );
  final FindSolutionsService findSolutionsService;
  final AutocompleteRepository autocompleteRepository;

  @override
  Future<List<Solution>> findSolutions(String departureLocationId,
      String arrivalLocationId, DateTime departureTime) async {
    List<Solution> solutions = [];
    try {
      final response = await findSolutionsService.findSolutions(
          departureLocationId, arrivalLocationId, departureTime);

      for (final solutionBlock in response["solutions"]) {
        final solution = solutionBlock["solution"];
        final departure =
            await autocompleteRepository.findStationByNameViaggiatreno(
                solution["origin"].toString().split("-")[0].trim());
        Solution solutionModel =
            SolutionModel.fromJson(solution, departure.code);
        solutions.add(solutionModel);
      }
      return solutions;
    } catch (e) {
      return Future.value([]);
    }
  }
}
