import 'package:treni_pendolari/domain/entities/train/train_status.dart';

class TrainStatusModel extends TrainStatus {
  TrainStatusModel(
      super.delay, super.lastTimeDetection, super.lastStopDetection);

  factory TrainStatusModel.fromJson(Map<String, dynamic> map) {
    return TrainStatusModel(map["ritardo"], map["compOraUltimoRilevamento"],
        map["stazioneUltimoRilevamento"]);
  }
}
