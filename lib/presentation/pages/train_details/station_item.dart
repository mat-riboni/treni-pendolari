import 'package:flutter/material.dart';
import 'package:treni_pendolari/configs/app_colors.dart';
import 'package:treni_pendolari/presentation/utils/date_time_formatter.dart';

class StationItem extends StatelessWidget {
  const StationItem({
    super.key,
    required this.isPassed,
    required this.departureTrack,
    required this.arrivalTime,
    required this.stationName,
    required this.isFirst,
    required this.isLast,
    required this.change,
  });
  final bool isPassed;
  final String departureTrack;
  final TimeOfDay? arrivalTime;
  final String stationName;
  final bool isFirst;
  final bool isLast;
  final bool change;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: isFirst
              ? Border.all(color: AppColors.lightGrey)
              : const Border(
                  bottom: BorderSide(color: AppColors.lighterGrey),
                  left: BorderSide(color: AppColors.lighterGrey),
                  right: BorderSide(color: AppColors.lighterGrey),
                ),
          borderRadius: isFirst
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))
              : isLast
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))
                  : BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 200,
              child: Text(
                stationName,
                style: isPassed
                    ? const TextStyle(fontWeight: FontWeight.w300)
                    : const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arrivalTime != null
                            ? DateTimeFormatter.timeOfDayToString(arrivalTime!)
                            : stationName == "Stazione"
                                ? "Arrivo"
                                : "...",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          departureTrack,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
