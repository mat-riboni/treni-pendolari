import 'package:treni_pendolari/domain/entities/routine/routine.dart';

abstract class RoutineRepository {
  Future<void> saveRoutine(Routine routine);
  Routine getRoutine();
}
