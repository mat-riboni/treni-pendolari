import 'package:treni_pendolari/data/models/train/train_model.dart';
import 'package:treni_pendolari/domain/entities/station/node.dart';
import 'package:treni_pendolari/domain/entities/train/train.dart';

class NodeModel extends Node {
  NodeModel(super.origin, super.destination, super.departureTime,
      super.arrivalTime, super.train);

  factory NodeModel.fromJson(Map<String, dynamic> map) {
    return NodeModel(map["origin"], map["destination"], map["departureTime"],
        map["arrivalTime"], TrainModel.fromJson(map));
  }

  @override
  Node copyWithTrain(Train train) {
    return NodeModel(origin, destination, departureTime, arrivalTime, train);
  }
}
