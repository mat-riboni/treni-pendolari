import 'package:treni_pendolari/data/models/train/stop_model.dart';
import 'package:treni_pendolari/data/models/train/train_model.dart';
import 'package:treni_pendolari/data/models/train/train_status_model.dart';
import 'package:treni_pendolari/data/sources/api/train_status_service.dart';
import 'package:treni_pendolari/domain/entities/train/stop.dart';
import 'package:treni_pendolari/domain/entities/train/train.dart';
import 'package:treni_pendolari/domain/entities/train/train_status.dart';
import 'package:treni_pendolari/domain/repositories/train_status_repository.dart';
import 'package:treni_pendolari/presentation/utils/date_time_formatter.dart';

class TrainStatusRepositoryImpl extends TrainStatusRepository {
  TrainStatusRepositoryImpl(this.trainStatusService);

  final TrainStatusService trainStatusService;

  @override
  Future<Train> getTrainWithStatus(
      Train train, DateTime date, String tripDepartureStationCode) async {
    final dateMills = DateTimeFormatter.dateTimeToMills(date);

    try {
      Map<String, dynamic> response =
          await trainStatusService.getTrainStatus(train, dateMills.toString());

      List<Stop> stops = [];
      String departureTripTrack = "";
      for (final stop in response["fermate"]) {
        final stopModel = StopModel.fromJson(stop);
        stops.add(stopModel);
        if (stopModel.station.code == tripDepartureStationCode) {
          departureTripTrack = stopModel.track;
        }
      }
      TrainStatus status = TrainStatusModel.fromJson(response);
      return TrainModel(
          id: train.id,
          originStationCode: train.originStationCode,
          status: status,
          stops: stops,
          category: train.category,
          categoryShort: train.categoryShort,
          departureTripTrack: departureTripTrack);
    } catch (e) {
      return TrainModel(
          id: train.id,
          originStationCode: train.originStationCode,
          status: TrainStatusModel(null, null, null),
          category: train.category,
          categoryShort: train.category);
    }
  }
}
