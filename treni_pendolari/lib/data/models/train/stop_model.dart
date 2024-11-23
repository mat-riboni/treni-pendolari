import 'package:treni_pendolari/data/models/station/station_model.dart';
import 'package:treni_pendolari/domain/entities/train/stop.dart';
import 'package:treni_pendolari/presentation/utils/date_time_formatter.dart';

class StopModel extends Stop {
  StopModel(
      super.station,
      super.track,
      super.arrivalDelay,
      super.programmedArrivalTime,
      super.programmedDepartureTime,
      super.realArrivalTime,
      super.realDepartureTime);

  factory StopModel.fromJson(Map<String, dynamic> map) {
    final station =
        StationModel(name: map["stazione"], locationId: "", code: map["id"]);
    final track = map["binarioEffettivoPartenzaDescrizione"] ??
        map["binarioProgrammatoPartenzaDescrizione"] ??
        'N/D';
    final programmedArrivalTime =
        DateTimeFormatter.millsToTimeOfDay(map["arrivo_teorico"] ?? 0);
    final programmedDepartureTime =
        DateTimeFormatter.millsToTimeOfDay(map["partenza_teorica"] ?? 0);
    final realArrivalTime =
        DateTimeFormatter.millsToTimeOfDay(map["arrivoReale"] ?? 0);
    final realDepartureTime =
        DateTimeFormatter.millsToTimeOfDay(map["partenzaReale"] ?? 0);
    final departureDelay = map["ritardoPartenza"]?.toString() ?? "";
    return StopModel(
      station,
      track,
      departureDelay,
      programmedArrivalTime,
      programmedDepartureTime,
      realArrivalTime,
      realDepartureTime,
    );
  }
}
