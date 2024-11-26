import 'package:treni_pendolari/data/models/station/node_model.dart';
import 'package:treni_pendolari/domain/entities/search/solution.dart';
import 'package:treni_pendolari/domain/entities/station/node.dart';
import 'package:treni_pendolari/domain/entities/train/train.dart';

class SolutionModel extends Solution {
  SolutionModel(
      {required super.from,
      required super.to,
      required super.duration,
      required super.departureTime,
      required super.arrivalTime,
      required super.originName,
      required super.originCode,
      required super.departureCode,
      required super.nodes});

  factory SolutionModel.fromJson(
      Map<String, dynamic> map, String departureCode) {
    final from = map["origin"];
    final to = map["destination"];
    final duration = map["duration"];
    final departureTime = map["departureTime"];
    final arrivalTime = map["arrivalTime"];
    final originName = map["nodes"][0]["origin"];
    final originCode = map["nodes"][0]["bdoOrigin"];
    List<Node> nodes = [];
    for (final node in map["nodes"]) {
      nodes.add(NodeModel.fromJson(node));
    }
    return SolutionModel(
        from: from,
        to: to,
        duration: duration,
        departureTime: departureTime,
        arrivalTime: arrivalTime,
        originName: originName,
        originCode: originCode,
        departureCode: departureCode,
        nodes: nodes);
  }

  @override
  Solution copyWithTrain(List<Train> trains) {
    List<Node> newNodes = [];
    int index = 0;
    for (final node in nodes) {
      newNodes.add(node.copyWithTrain(trains[index]));
      index++;
    }
    return SolutionModel(
        from: from,
        to: to,
        duration: duration,
        departureTime: departureTime,
        arrivalTime: arrivalTime,
        originName: originName,
        originCode: originCode,
        departureCode: departureCode,
        nodes: newNodes);
  }
}
