abstract class TrainStatus {
  TrainStatus(this.delay, this.lastTimeDetection, this.lastStopDetection);

  final int delay;
  final String lastTimeDetection;
  final String lastStopDetection;
}
