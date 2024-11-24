import 'package:treni_pendolari/data/models/search/response_trip_model.dart';
import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/domain/entities/search/solution.dart';
import 'package:treni_pendolari/domain/entities/train/train.dart';
import 'package:treni_pendolari/domain/repositories/search_repository.dart';
import 'package:treni_pendolari/domain/repositories/solution_repository.dart';
import 'package:treni_pendolari/domain/repositories/train_status_repository.dart';
import 'package:treni_pendolari/presentation/utils/date_time_formatter.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this.trainStatusRepository, this.solutionRepository);

  final TrainStatusRepository trainStatusRepository;
  final SolutionRepository solutionRepository;

  @override
  Future<List<ResponseTrip>> searchTrip(SearchingTrip trip) async {
    List<Solution> solutions = await solutionRepository.findSolutions(
        trip.from.locationId, trip.to.locationId, trip.departureDateTime);

    List<ResponseTrip> tripsFound = [];

    for (Solution solution in solutions) {
      List<Train> trains = [];
      for (final node in solution.nodes) {
        Train train = await trainStatusRepository.getTrainWithStatus(
            node.train, trip.departureDateTime, solution.departureCode);
        trains.add(train);
      }
      final tripModel = ResponseTripModel(
          from: trip.from,
          to: trip.to,
          departureTime: DateTimeFormatter.dateTimeStringToTimeOfDay(
              solution.departureTime),
          arrivalTime:
              DateTimeFormatter.dateTimeStringToTimeOfDay(solution.arrivalTime),
          delay: buildDelay(trains),
          duration: solution.duration,
          departureTrack: trains[0].departureTripTrack,
          nodes: solution.nodes);
      tripsFound.add(tripModel);
    }

    return tripsFound;
  }

  String buildDelay(List<Train> trains) {
    bool isFirst = true;
    String delay = "";
    for (final train in trains) {
      if (isFirst && train.status != null) {
        delay = delay + train.status!.delay.toString();
        isFirst = false;
      } else if (train.status != null) {
        delay = "$delay | ${train.status?.delay.toString() ?? ""}";
      }
    }
    return delay;
  }
}
