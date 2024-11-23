import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:treni_pendolari/configs/app_colors.dart';
import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/presentation/utils/date_time_formatter.dart';

class ResponseTripList extends StatelessWidget {
  const ResponseTripList({super.key, required this.responseList, this.trip});
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
                    return Column(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.train,
                                              color: AppColors.lightGrey,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${responseList[index].nodes[0].train.categoryShort} ${responseList[index].nodes[0].train.id}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.lightGrey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Expanded(
                                      child: Row(),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/train_track.svg",
                                              width: 30,
                                            ),
                                            const Text("Binario: ",
                                                style: TextStyle(
                                                    color: AppColors.lightGrey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12)),
                                            Text(
                                              responseList[index]
                                                  .departureTrack,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      DateTimeFormatter.timeOfDayToString(
                                          responseList[index].departureTime),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      responseList[index].from.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.lightGrey,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      DateTimeFormatter.timeOfDayToString(
                                          responseList[index].arrivalTime),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      responseList[index].to.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.lightGrey,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        "Cambi: ${(responseList[index].nodes.length - 1).toString()}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightGrey,
                                        )),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              responseList[index].duration,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            (!DateTimeFormatter.isTimeAfterNow(
                                                        responseList[index]
                                                            .departureTime) &&
                                                    responseList[index]
                                                        .delay
                                                        .isNotEmpty)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: DateTimeFormatter
                                                                  .isDelayPositive(
                                                                      responseList[
                                                                              index]
                                                                          .delay)
                                                              ? const Color(
                                                                  0xffFFDDDD)
                                                              : const Color(
                                                                  0xffD5FADC),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                          "${DateTimeFormatter.isDelayPositiveOrZero(responseList[index].delay) ? "+" : ""}${responseList[index].delay}",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: DateTimeFormatter.isDelayPositive(
                                                                      responseList[
                                                                              index]
                                                                          .delay)
                                                                  ? const Color(
                                                                      0xffC00000)
                                                                  : Colors
                                                                      .green),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        )
                      ],
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
}
