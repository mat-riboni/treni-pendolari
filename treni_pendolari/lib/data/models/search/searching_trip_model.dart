import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/domain/entities/station/station.dart';

class SearchingTripModel extends SearchingTrip {
  SearchingTripModel(super.from, super.to, super.departureDateTime);

  @override
  SearchingTrip copyWith(
      {Station? from, Station? to, DateTime? departureDateTime}) {
    return SearchingTripModel(from ?? this.from, to ?? this.to,
        departureDateTime ?? this.departureDateTime);
  }
}
