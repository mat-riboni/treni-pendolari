import 'package:shared_preferences/shared_preferences.dart';
import 'package:treni_pendolari/data/sources/shared_preferences/routine/routine_keys.dart';
import 'package:treni_pendolari/domain/entities/routine/routine.dart';

class SharedPreferencesRoutine {
  final SharedPreferences sharedPreferencesRoutine;

  SharedPreferencesRoutine(this.sharedPreferencesRoutine);

  Future<void> saveRoutine(Routine routine) async {
    await sharedPreferencesRoutine.setString(
        RoutineKeys.departureFrom, routine.daparture.from);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.departureFromId, routine.daparture.fromId);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.departureFromCode, routine.daparture.fromCode);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.departureTo, routine.daparture.to);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.departureToId, routine.daparture.toId);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.departureToCode, routine.daparture.toCode);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.homecomingFrom, routine.homecoming.from);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.homecomingFromId, routine.homecoming.fromId);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.homecomingFromCode, routine.homecoming.fromCode);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.homecomingTo, routine.homecoming.to);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.homecomingToId, routine.homecoming.toId);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.homecomingToCode, routine.homecoming.toCode);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.departureTime, routine.daparture.departureTime);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.homecomingTime, routine.homecoming.departureTime);

    await sharedPreferencesRoutine.setString(
        RoutineKeys.switchTripTime, routine.switchTripTime);

    await sharedPreferencesRoutine.setBool(
        RoutineKeys.isFirstOpening, routine.isFirstOpening);
  }

  String? getDepartureFrom() =>
      sharedPreferencesRoutine.getString(RoutineKeys.departureFrom);
  String? getDepartureFromId() =>
      sharedPreferencesRoutine.getString(RoutineKeys.departureFromId);
  String? getDepartureFromCode() =>
      sharedPreferencesRoutine.getString(RoutineKeys.departureFromCode);
  String? getDepartureTo() =>
      sharedPreferencesRoutine.getString(RoutineKeys.departureTo);
  String? getDepartureToId() =>
      sharedPreferencesRoutine.getString(RoutineKeys.departureToId);
  String? getDepartureToCode() =>
      sharedPreferencesRoutine.getString(RoutineKeys.departureToCode);
  String? getDepartureTime() =>
      sharedPreferencesRoutine.getString(RoutineKeys.departureTime);
  String? getHomecomingFrom() =>
      sharedPreferencesRoutine.getString(RoutineKeys.homecomingFrom);
  String? getHomecomingFromId() =>
      sharedPreferencesRoutine.getString(RoutineKeys.homecomingFromId);
  String? getHomecomingFromCode() =>
      sharedPreferencesRoutine.getString(RoutineKeys.homecomingFromCode);
  String? getHomecomingTo() =>
      sharedPreferencesRoutine.getString(RoutineKeys.homecomingTo);
  String? getHomecomingToId() =>
      sharedPreferencesRoutine.getString(RoutineKeys.homecomingToId);
  String? getHomecomingToCode() =>
      sharedPreferencesRoutine.getString(RoutineKeys.homecomingToCode);
  String? getHomecomingTime() =>
      sharedPreferencesRoutine.getString(RoutineKeys.homecomingTime);
  String? getSwitchTripTime() =>
      sharedPreferencesRoutine.getString(RoutineKeys.switchTripTime);
  bool? getIsFirstOpening() =>
      sharedPreferencesRoutine.getBool(RoutineKeys.isFirstOpening);
}
