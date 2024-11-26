import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treni_pendolari/configs/app_colors.dart';
import 'package:treni_pendolari/configs/app_text_styles.dart';
import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/presentation/pages/train_details/train_details.dart';
import 'package:treni_pendolari/presentation/utils/date_time_formatter.dart';

class HomeResponseList extends StatelessWidget {
  const HomeResponseList({super.key, required this.responseList, this.trip});
  final List<ResponseTrip> responseList;
  final SearchingTrip? trip;

  @override
  Widget build(BuildContext context) {
    if (responseList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 3),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.lighterGrey),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        responseList[0].from.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(Icons.arrow_right_alt, size: 30),
                    Flexible(
                      flex: 1,
                      child: Text(
                        responseList[0].to.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: responseList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (responseList[index].nodes[0].train.status != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TrainDetailsPage(
                                      responseTrip: responseList[index])));
                        } else {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Dettagli non disponibili",
                                        style: AppTextStyles.h1,
                                      ),
                                      Text(
                                        "I dettagli del treno non sono stati forniti",
                                        style: AppTextStyles.h3,
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.lighterGrey,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Column(
                                children: [
                                  _descriptionRow(
                                      DateTimeFormatter.timeOfDayToString(
                                          responseList[index].departureTime),
                                      responseList[index].from.name,
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/train_track.svg",
                                            width: 30,
                                          ),
                                          Text(
                                            responseList[index].departureTrack,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          )
                                        ],
                                      )),
                                  _descriptionRow(
                                    DateTimeFormatter.timeOfDayToString(
                                        responseList[index].arrivalTime),
                                    responseList[index].to.name,
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: DateTimeFormatter
                                                      .isDelayPositive(
                                                          responseList[index]
                                                              .delay)
                                                  ? const Color(0xffFFDDDD)
                                                  : const Color(0xffD5FADC),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "${DateTimeFormatter.isDelayPositiveOrZero(responseList[index].delay) ? "+" : ""}${responseList[index].delay}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: DateTimeFormatter
                                                          .isDelayPositive(
                                                              responseList[
                                                                      index]
                                                                  .delay)
                                                      ? const Color(0xffC00000)
                                                      : Colors.green),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    } else {
      return const Center(child: Text("Effettua una ricerca"));
    }
  }

  Widget _descriptionRow(String time, String stationName, Widget trail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              stationName,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.lightGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trail,
      ],
    );
  }
}
