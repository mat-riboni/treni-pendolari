import 'package:treni_pendolari/domain/entities/train/stop.dart';
import 'package:treni_pendolari/domain/entities/train/train_status.dart';

abstract class Train {
  Train(
      {required this.id,
      this.category = "",
      this.categoryShort = "",
      required this.originStationCode,
      this.status,
      this.departureTripTrack = "",
      List<Stop>? stops})
      : stops = stops ?? [];

  final String id;
  final String category;
  final String categoryShort;
  final String originStationCode;
  final TrainStatus? status;
  final String departureTripTrack;
  final List<Stop> stops;
}
