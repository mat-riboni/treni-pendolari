import 'package:flutter/material.dart';
import 'package:treni_pendolari/configs/app_colors.dart';
import 'package:treni_pendolari/presentation/pages/home/home_text_input.dart';

// ignore: must_be_immutable
class DateTimeSwapBlock extends StatefulWidget {
  const DateTimeSwapBlock({
    super.key,
    required this.fromController,
    required this.toController,
    required this.swapDestinations,
    required this.dateTimePickerController,
    required this.showDateTimePicker,
  });
  final TextEditingController fromController;
  final TextEditingController toController;
  final Function swapDestinations;
  final TextEditingController dateTimePickerController;
  final Function showDateTimePicker;

  @override
  State<DateTimeSwapBlock> createState() => _DatetimeSwapBlockState();
}

class _DatetimeSwapBlockState extends State<DateTimeSwapBlock> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Stack(
              children: [
                HomeTextInput(
                    bottomLeft: 10,
                    controller: widget.dateTimePickerController,
                    hint: "Data e Ora",
                    icon: const Icon(
                      Icons.access_time_filled,
                      color: AppColors.lightGrey,
                    )),
                Positioned.fill(
                    child: InkWell(
                  onTap: () {
                    widget.showDateTimePicker();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
              ],
            )),
        Expanded(
            flex: 2,
            child: Stack(children: [
              const HomeTextInput(
                  bottomRight: 10,
                  hint: "Scambia",
                  icon: Icon(
                    Icons.swap_vert,
                    color: AppColors.lightGrey,
                  )),
              Positioned.fill(
                child: InkWell(
                    onTap: () {
                      widget.swapDestinations();
                    },
                    child: Container(
                      color: Colors.transparent,
                    )),
              )
            ])),
      ],
    );
  }
}
