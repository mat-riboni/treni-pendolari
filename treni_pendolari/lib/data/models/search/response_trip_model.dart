import 'package:treni_pendolari/domain/entities/search/response_trip.dart';

class ResponseTripModel extends ResponseTrip {
  ResponseTripModel(
      {required super.departureTrack,
      required super.from,
      required super.to,
      required super.departureTime,
      required super.arrivalTime,
      required super.delay,
      required super.duration,
      required super.nodes});
}
