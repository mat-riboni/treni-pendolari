import 'package:treni_pendolari/domain/entities/station/node.dart';
import 'package:treni_pendolari/domain/entities/train/train.dart';

abstract class Solution {
  Solution(
      {required this.from,
      required this.to,
      required this.duration,
      required this.departureTime,
      required this.arrivalTime,
      required this.originName,
      required this.originCode,
      required this.departureCode,
      required this.nodes});
  final String from;
  final String to;
  final String duration;
  final String departureTime;
  final String arrivalTime;
  final String originName;
  final String originCode;
  final String departureCode;
  final List<Node> nodes;

  Solution copyWithTrain(List<Train> trains);
}
