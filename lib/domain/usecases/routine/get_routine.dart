import 'package:treni_pendolari/domain/entities/routine/routine.dart';
import 'package:treni_pendolari/domain/repositories/routine_repository.dart';

class GetRoutineUseCase {
  final RoutineRepository routineRepository;
  GetRoutineUseCase(this.routineRepository);

  Routine call() {
    return routineRepository.getRoutine();
  }
}
