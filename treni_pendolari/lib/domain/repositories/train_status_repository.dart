import 'package:treni_pendolari/domain/entities/train/train.dart';

abstract class TrainStatusRepository {
  Future<Train> getTrainWithStatus(
      Train train, DateTime date, String tripDepartureStationCode);
}
