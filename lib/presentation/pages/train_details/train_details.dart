import 'package:flutter/material.dart';
import 'package:treni_pendolari/configs/app_colors.dart';
import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/presentation/pages/train_details/station_item.dart';
import 'package:treni_pendolari/presentation/widgets/app_bar.dart';

class TrainDetailsPage extends StatelessWidget {
  const TrainDetailsPage({super.key, required this.responseTrip});
  final ResponseTrip responseTrip;

  @override
  Widget build(BuildContext context) {
    bool isPassed = true;
    return Scaffold(
      appBar: const BasicAppBar(
        showLeading: true,
        title: Text(
          "Dettagli viaggio",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.lighterGrey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text("Numero: ", style: TextStyle(fontSize: 16))
                          ]),
                          Row(children: [
                            Text("Provenienza: ",
                                style: TextStyle(fontSize: 16))
                          ]),
                          Row(children: [
                            Text("Capolinea: ", style: TextStyle(fontSize: 16))
                          ]),
                          Row(children: [
                            Text("Ritardo: ", style: TextStyle(fontSize: 16))
                          ]),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              "${responseTrip.nodes[0].train.categoryShort} ${responseTrip.nodes[0].train.id}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          Row(children: [
                            Text(
                              responseTrip.nodes[0].train.stops[0].station.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          Row(children: [
                            Text(
                              responseTrip.nodes[0].destination,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ]),
                          Row(children: [
                            (responseTrip.nodes[0].train.status != null)
                                ? Text(
                                    responseTrip.nodes[0].train.status!.delay
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                : const Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    const StationItem(
                        isPassed: false,
                        departureTrack: "Binario",
                        arrivalTime: null,
                        stationName: "Stazione",
                        isFirst: true,
                        isLast: false,
                        change: false),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: responseTrip.nodes.length,
                      itemBuilder: (context, listIndex) {
                        bool haveToChange = false;
                        final node = responseTrip.nodes[listIndex];
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: node.train.stops.length,
                          itemBuilder: (context, index) {
                            final stop = node.train.stops[index];
                            if (stop.station.name.toLowerCase() ==
                                node.train.status!.lastStopDetection
                                    ?.toLowerCase()) {
                              isPassed = false;
                            }
                            if (node.destination == stop.station.name &&
                                node != responseTrip.nodes.last) {
                              haveToChange = true;

                              return Column(
                                children: [
                                  StationItem(
                                      isPassed: isPassed,
                                      departureTrack: stop.track,
                                      arrivalTime: stop.realArrivalTime == 0
                                          ? stop.realArrivalTime
                                          : stop.programmedArrivalTime,
                                      stationName: stop.station.name,
                                      isFirst: false,
                                      isLast: false,
                                      change: false),
                                  StationItem(
                                      isPassed: isPassed,
                                      departureTrack: stop.track,
                                      arrivalTime: stop.realArrivalTime == 0
                                          ? stop.realArrivalTime
                                          : stop.programmedArrivalTime,
                                      stationName: stop.station.name,
                                      isFirst: false,
                                      isLast: false,
                                      change: true),
                                ],
                              );
                            }
                            if (haveToChange) {
                              return Container();
                            } else {
                              return StationItem(
                                  isPassed: isPassed,
                                  departureTrack: stop.track,
                                  arrivalTime: stop.realDepartureTime == 0
                                      ? stop.realDepartureTime
                                      : stop.programmedDepartureTime,
                                  stationName: stop.station.name,
                                  isFirst: false,
                                  isLast: index == node.train.stops.length - 1,
                                  change: false);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
