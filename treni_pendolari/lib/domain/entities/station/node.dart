import 'package:treni_pendolari/domain/entities/train/train.dart';

abstract class Node {
  final String origin;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final Train train;
  Node(this.origin, this.destination, this.departureTime, this.arrivalTime,
      this.train);

  Node copyWithTrain(Train train);
}
