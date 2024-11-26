import 'package:treni_pendolari/domain/entities/station/station.dart';

abstract class SearchingTrip {
  SearchingTrip(this.from, this.to, this.departureDateTime);

  final Station from;
  final Station to;
  final DateTime departureDateTime;

  SearchingTrip copyWith(
      {Station? from, Station? to, DateTime? departureDateTime});
}
