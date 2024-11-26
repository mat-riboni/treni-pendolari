import 'package:flutter/material.dart';
import 'package:treni_pendolari/data/models/search/searching_trip_model.dart';
import 'package:treni_pendolari/data/models/station/station_model.dart';
import 'package:treni_pendolari/domain/entities/routine/routine.dart';
import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/domain/entities/station/station.dart';
import 'package:treni_pendolari/domain/repositories/first_search_repository.dart';
import 'package:treni_pendolari/domain/repositories/routine_repository.dart';
import 'package:treni_pendolari/domain/repositories/search_repository.dart';
import 'package:treni_pendolari/presentation/utils/date_time_formatter.dart';

class FirstSearchRepositoryImpl implements FirstSearchRepository {
  FirstSearchRepositoryImpl(this.routineRepository, this.searchRepository);
  final SearchRepository searchRepository;
  final RoutineRepository routineRepository;
  @override
  Future<List<ResponseTrip>> getRoutineAndSearch() {
    Routine routine = routineRepository.getRoutine();
    SearchingTrip trip;
    Station from;
    Station to;
    DateTime switchDateTime;
    print(routine.homecoming.from);
    print(routine.homecoming.fromId);
    print(routine.homecoming.to);
    print(routine.homecoming.toId);

    if (routine.switchTripTime.isNotEmpty) {
      TimeOfDay switchTime =
          DateTimeFormatter.stringToTimeOfDay(routine.switchTripTime);
      final now = DateTime.now();
      switchDateTime = DateTime(
          now.year, now.month, now.day, switchTime.hour, switchTime.minute);
    } else {
      TimeOfDay departureTime =
          DateTimeFormatter.stringToTimeOfDay(routine.daparture.departureTime);
      TimeOfDay homecomingTime =
          DateTimeFormatter.stringToTimeOfDay(routine.homecoming.departureTime);
      final switchTime =
          DateTimeFormatter.timeInMiddle(departureTime, homecomingTime);
      final now = DateTime.now();

      switchDateTime = DateTime(
          now.year, now.month, now.day, switchTime.hour, switchTime.minute);
    }

    if (DateTime.now().isAfter(switchDateTime)) {
      from = StationModel(
          name: routine.homecoming.from,
          locationId: routine.homecoming.fromId,
          code: routine.homecoming.fromCode);
      to = StationModel(
          name: routine.homecoming.to,
          locationId: routine.homecoming.toId,
          code: routine.homecoming.toCode);
      trip = SearchingTripModel(from, to, DateTime.now());
    } else {
      from = StationModel(
          name: routine.daparture.from,
          locationId: routine.daparture.fromId,
          code: routine.daparture.fromCode);
      to = StationModel(
          name: routine.daparture.to,
          locationId: routine.daparture.toId,
          code: routine.daparture.toCode);
      trip = SearchingTripModel(from, to, DateTime.now());
    }

    return searchRepository.searchTrip(trip);
  }
}
