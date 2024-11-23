import 'package:treni_pendolari/domain/entities/routine/routine.dart';
import 'package:treni_pendolari/domain/repositories/routine_repository.dart';

class SaveRoutineUseCase {
  final RoutineRepository routineRepository;

  SaveRoutineUseCase(this.routineRepository);

  Future<void> call(Routine routine) {
    return routineRepository.saveRoutine(routine);
  }
}
