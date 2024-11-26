import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treni_pendolari/data/repositories/autocomplete_repository_impl.dart';
import 'package:treni_pendolari/data/repositories/first_search_repository_impl.dart';
import 'package:treni_pendolari/data/repositories/routine_repository_impl.dart';
import 'package:treni_pendolari/data/repositories/search_repository_impl.dart';
import 'package:treni_pendolari/data/repositories/solution_repository_impl.dart';
import 'package:treni_pendolari/data/repositories/train_status_repository_impl.dart';
import 'package:treni_pendolari/data/sources/api/autocomplete_service.dart';
import 'package:treni_pendolari/data/sources/api/find_solutions_service.dart';
import 'package:treni_pendolari/data/sources/api/train_status_service.dart';
import 'package:treni_pendolari/data/sources/shared_preferences/routine/shared_preferences_routine.dart';
import 'package:treni_pendolari/domain/repositories/autocomplete_repository.dart';
import 'package:treni_pendolari/domain/repositories/first_search_repository.dart';
import 'package:treni_pendolari/domain/repositories/routine_repository.dart';
import 'package:treni_pendolari/domain/repositories/search_repository.dart';
import 'package:treni_pendolari/domain/repositories/solution_repository.dart';
import 'package:treni_pendolari/domain/repositories/train_status_repository.dart';
import 'package:treni_pendolari/domain/usecases/routine/get_routine.dart';
import 'package:treni_pendolari/domain/usecases/routine/save_routine.dart';
import 'package:treni_pendolari/domain/usecases/search/first_search.dart';
import 'package:treni_pendolari/domain/usecases/search/search_trip.dart';

final getIt = GetIt.instance;

Future<void> startUp() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //Shared Preferences
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerSingleton<SharedPreferencesRoutine>(
      SharedPreferencesRoutine(sharedPreferences));

  //Routine
  getIt.registerSingleton<RoutineRepository>(
      RoutineRepositoryImpl(getIt.get<SharedPreferencesRoutine>()));

  getIt.registerSingleton<GetRoutineUseCase>(
      GetRoutineUseCase(getIt.get<RoutineRepository>()));

  getIt.registerSingleton<SaveRoutineUseCase>(
      SaveRoutineUseCase(getIt.get<RoutineRepository>()));

  //Search
  getIt.registerSingleton<AutocompleteService>(AutocompleteService());
  getIt.registerSingleton<FindSolutionsService>(FindSolutionsService());
  getIt.registerSingleton<TrainStatusService>(TrainStatusService());
  getIt.registerSingleton<TrainStatusRepository>(
      TrainStatusRepositoryImpl(getIt.get<TrainStatusService>()));

  getIt.registerSingleton<AutocompleteRepository>(
      AutocompleteRepositoryImpl(getIt.get<AutocompleteService>()));

  getIt.registerSingleton<TrainStatusRepositoryImpl>(
      TrainStatusRepositoryImpl(getIt.get<TrainStatusService>()));

  getIt.registerSingleton<SolutionRepository>(SolutionRepositoryImpl(
      getIt.get<FindSolutionsService>(), getIt.get<AutocompleteRepository>()));

  getIt.registerSingleton<SearchRepository>(SearchRepositoryImpl(
      getIt.get<TrainStatusRepository>(), getIt.get<SolutionRepository>()));

  getIt.registerSingleton<SearchTripUseCase>(
      SearchTripUseCase(getIt.get<SearchRepository>()));

  getIt.registerSingleton<FirstSearchRepository>(FirstSearchRepositoryImpl(
      getIt.get<RoutineRepository>(), getIt.get<SearchRepository>()));

  getIt.registerSingleton<FirstSearchUseCase>(
      FirstSearchUseCase(getIt.get<FirstSearchRepository>()));
}
