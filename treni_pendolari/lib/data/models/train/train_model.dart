import 'package:treni_pendolari/domain/entities/train/train.dart';

class TrainModel extends Train {
  TrainModel(
      {required super.id,
      super.category,
      super.categoryShort,
      required super.originStationCode,
      super.status,
      super.stops,
      super.departureTripTrack});

  factory TrainModel.fromJson(Map<String, dynamic> map) {
    final originStationCode = map["bdoOrigin"];
    final trainId = map["train"]["name"];
    final category = map["train"]["trainCategory"];
    final categoryShort = map["train"]["acronym"];
    return TrainModel(
        id: trainId,
        originStationCode: originStationCode,
        category: category,
        categoryShort: categoryShort);
  }
}
