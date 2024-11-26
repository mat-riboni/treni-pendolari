import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:treni_pendolari/data/models/search/searching_trip_model.dart';
import 'package:treni_pendolari/data/models/station/station_model.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/presentation/widgets/app_page_route_builder.dart';
import 'package:treni_pendolari/presentation/pages/home/date_time_swap_block.dart';
import 'package:treni_pendolari/presentation/pages/home/home_text_input.dart';
import 'package:treni_pendolari/presentation/pages/home/search_button.dart';
import 'package:treni_pendolari/presentation/utils/date_time_formatter.dart';
import 'package:treni_pendolari/presentation/widgets/search_station.dart';

class FormBlock extends StatefulWidget {
  const FormBlock({
    super.key,
    required this.fromController,
    required this.toController,
    required this.onClickSearch,
    required this.dateTimePickerController,
  });
  final TextEditingController fromController;
  final TextEditingController toController;
  final TextEditingController dateTimePickerController;
  final void Function(SearchingTrip trip) onClickSearch;

  @override
  State<FormBlock> createState() => _FormBlockState();
}

class _FormBlockState extends State<FormBlock> {
  SearchingTrip currentTrip = SearchingTripModel(
      StationModel(name: "", locationId: "", code: ""),
      StationModel(name: "", locationId: "", code: ""),
      DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        child: Column(
          children: [
            Stack(children: [
              HomeTextInput(
                  top: 10,
                  hint: "Partenza:",
                  controller: widget.fromController),
              Positioned.fill(
                  child: InkWell(
                onTap: _changeTrip,
                child: Container(
                  color: Colors.transparent,
                ),
              ))
            ]),
            Stack(children: [
              HomeTextInput(hint: "Arrivo:", controller: widget.toController),
              Positioned.fill(
                  child: InkWell(
                onTap: _changeTrip,
                child: Container(
                  color: Colors.transparent,
                ),
              ))
            ]),
            DateTimeSwapBlock(
              fromController: widget.fromController,
              toController: widget.toController,
              swapDestinations: _swapDestinations,
              dateTimePickerController: widget.dateTimePickerController,
              showDateTimePicker: _showDateTimePicker,
            ),
            const SizedBox(
              height: 10,
            ),
            SearchButton(
              onClick: widget.onClickSearch,
              trip: currentTrip,
            )
          ],
        ),
      ),
    );
  }

  void _changeTrip() async {
    currentTrip =
        await Navigator.of(context).push(AppPageRouteBuilder(SearchStationPage(
      trip: currentTrip,
    )));
    setState(() {
      if (currentTrip.from.name.isNotEmpty) {
        widget.fromController.text = currentTrip.from.name;
      } else {
        currentTrip = currentTrip.copyWith(
            from: StationModel(name: "", locationId: "", code: ""));
      }
      if (currentTrip.to.name.isNotEmpty) {
        widget.toController.text = currentTrip.to.name;
      } else {
        currentTrip = currentTrip.copyWith(
            to: StationModel(name: "", locationId: "", code: ""));
      }
    });
  }

  void _swapDestinations() {
    setState(() {
      currentTrip =
          currentTrip.copyWith(from: currentTrip.to, to: currentTrip.from);
      widget.fromController.text = currentTrip.from.name;
      widget.toController.text = currentTrip.to.name;
    });
  }

  void _showDateTimePicker() async {
    DateTime? dateTime = await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        currentTime: DateTime.now(),
        locale: LocaleType.it);
    currentTrip =
        currentTrip.copyWith(departureDateTime: dateTime ?? DateTime.now());
    setState(() {
      widget.dateTimePickerController.text =
          DateTimeFormatter.dateTimeToString(dateTime ?? DateTime.now());
    });
  }
}
