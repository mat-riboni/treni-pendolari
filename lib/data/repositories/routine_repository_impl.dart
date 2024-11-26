import 'package:treni_pendolari/data/models/routine/routine_model.dart';
import 'package:treni_pendolari/data/models/routine/routine_trip_model.dart';
import 'package:treni_pendolari/data/sources/shared_preferences/routine/shared_preferences_routine.dart';
import 'package:treni_pendolari/domain/entities/routine/routine.dart';
import 'package:treni_pendolari/domain/repositories/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final SharedPreferencesRoutine spRoutine;

  RoutineRepositoryImpl(this.spRoutine);

  @override
  Routine getRoutine() {
    final String departureFrom = spRoutine.getDepartureFrom() ?? "";
    final String departureFromId = spRoutine.getDepartureFromId() ?? "";
    final String departureFromCode = spRoutine.getDepartureFromCode() ?? "";
    final String departureTo = spRoutine.getDepartureTo() ?? "";
    final String departureToId = spRoutine.getDepartureToId() ?? "";
    final String departureToCode = spRoutine.getDepartureToCode() ?? "";
    final String departureTime = spRoutine.getDepartureTime() ?? "";
    final String homecomingFrom = spRoutine.getHomecomingFrom() ?? "";
    final String homecomingFromId = spRoutine.getHomecomingFromId() ?? "";
    final String homecomingFromCode = spRoutine.getHomecomingFromCode() ?? "";
    final String homecomingTo = spRoutine.getHomecomingTo() ?? "";
    final String homecomingToId = spRoutine.getHomecomingToId() ?? "";
    final String homecomingToCode = spRoutine.getHomecomingToCode() ?? "";
    final String homecomingTime = spRoutine.getHomecomingTime() ?? "";
    final String switchTripTime = spRoutine.getSwitchTripTime() ?? "";
    final bool isFirstOpening = spRoutine.getIsFirstOpening() ?? true;

    final RoutineTripModel departure = RoutineTripModel(
        from: departureFrom,
        fromId: departureFromId,
        fromCode: departureFromCode,
        to: departureTo,
        toId: departureToId,
        toCode: departureToCode,
        departureTime: departureTime);
    final RoutineTripModel homecoming = RoutineTripModel(
        from: homecomingFrom,
        fromId: homecomingFromId,
        fromCode: homecomingFromCode,
        to: homecomingTo,
        toId: homecomingToId,
        toCode: homecomingToCode,
        departureTime: homecomingTime);

    return RoutineModel(departure, homecoming, isFirstOpening, switchTripTime);
  }

  @override
  Future<void> saveRoutine(Routine routine) async {
    await spRoutine.saveRoutine(routine);
  }
}
