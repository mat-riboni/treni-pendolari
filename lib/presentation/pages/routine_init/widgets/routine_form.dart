import 'package:flutter/material.dart';
import 'package:treni_pendolari/configs/app_colors.dart';
import 'package:treni_pendolari/configs/app_text_styles.dart';
import 'package:treni_pendolari/configs/app_theme.dart';
import 'package:treni_pendolari/data/models/routine/routine_trip_model.dart';
import 'package:treni_pendolari/data/models/search/searching_trip_model.dart';
import 'package:treni_pendolari/data/models/station/station_model.dart';
import 'package:treni_pendolari/domain/entities/routine/routine_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/presentation/widgets/app_page_route_builder.dart';
import 'package:treni_pendolari/presentation/widgets/search_station.dart';

class RoutineForm extends StatefulWidget {
  const RoutineForm(
      {super.key,
      required this.title,
      required this.firstLabel,
      required this.secondLabel,
      required this.thirdLabel,
      required this.nextAction,
      required this.onFormSubmit,
      required this.skip,
      this.departureTrip});

  final String title;
  final String firstLabel;
  final String secondLabel;
  final String thirdLabel;
  final RoutineTrip? departureTrip;
  final VoidCallback nextAction;
  final Function(RoutineTrip) onFormSubmit;
  final Function skip;

  @override
  // ignore: library_private_types_in_public_api
  _RoutineFormState createState() => _RoutineFormState();
}

class _RoutineFormState extends State<RoutineForm> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  late TimeOfDay selectedTime;
  RoutineTrip _trip = RoutineTripModel(
      from: "",
      to: "",
      departureTime: const TimeOfDay(hour: 0, minute: 0),
      fromId: "",
      toId: "",
      fromCode: "",
      toCode: "");
  @override
  void initState() {
    super.initState();

    selectedTime = TimeOfDay.now();
    String timeString = selectedTime
        .toString()
        .substring(10, selectedTime.toString().length - 1);
    timeController.text = timeString;
    _trip = _trip.copyWith(departureTime: selectedTime);
    if (widget.departureTrip != null) {
      _trip = _trip.copyWith(
          from: widget.departureTrip!.to, to: widget.departureTrip!.from);
    }
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      helpText: "Inserisci Ora",
      cancelText: "Annulla",
      hourLabelText: "Ore",
      minuteLabelText: "Minuti",
    );
    print(newTime);
    setState(() {
      if (newTime != null) {
        selectedTime = newTime;
        String timeString = selectedTime
            .toString()
            .substring(10, selectedTime.toString().length - 1);
        timeController.text = timeString;
        _trip = _trip.copyWith(departureTime: selectedTime);
      }
    });
  }

  void _searchStations() async {
    SearchingTrip searchingTrip = SearchingTripModel(
        StationModel(name: "", locationId: "", code: ""),
        StationModel(name: "", locationId: "", code: ""),
        DateTime.now());
    searchingTrip = await Navigator.of(context)
        .push(AppPageRouteBuilder(SearchStationPage(trip: searchingTrip)));
    _selectTime();

    if (searchingTrip.from.name.isNotEmpty) {
      setState(() {
        fromController.text = searchingTrip.from.name;
        _trip = _trip.copyWith(from: searchingTrip.from.name);
        _trip = _trip.copyWith(fromId: searchingTrip.from.locationId);
      });
    }
    if (searchingTrip.to.name.isNotEmpty) {
      setState(() {
        toController.text = searchingTrip.to.name;
        _trip = _trip.copyWith(to: searchingTrip.to.name);
        _trip = _trip.copyWith(toId: searchingTrip.to.locationId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyles.h1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _textInput(widget.firstLabel, "Stazione di partenza",
                        fromController, false),
                    const SizedBox(
                      height: 10,
                    ),
                    _textInput(
                      widget.secondLabel,
                      "Orario di partenza",
                      timeController,
                      true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _textInput(widget.thirdLabel, "Stazione di arrivo",
                        toController, false),
                    const SizedBox(
                      height: 40,
                    ),
                    _buttons(widget.nextAction, widget.skip),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Potrai modificare le scelte nelle impostazioni",
                  style: TextStyle(
                    color: Color(0xff6B6B6B),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textInput(String label, String hint, TextEditingController controller,
      bool showTimePicker) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label,
        style: AppTextStyles.h3,
      ),
      const SizedBox(
        height: 5,
      ),
      Stack(children: [
        TextField(
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(hintText: hint)
              .applyDefaults(AppTheme.theme.inputDecorationTheme),
        ),
        Positioned.fill(
            child: InkWell(
          onTap: showTimePicker ? _selectTime : _searchStations,
          child: Container(
            color: Colors.transparent, // Rende il contenitore invisibile
          ),
        ))
      ]),
    ]);
  }

  Widget _buttons(VoidCallback nextAction, Function skip) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            skip();
          },
          child: const Text(
            "Salta",
            style: AppTextStyles.h3,
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              await widget.onFormSubmit(_trip);
              nextAction();
            },
            child: Text(
              "Avanti",
              style: AppTextStyles.h3.copyWith(color: Colors.white),
            ))
      ],
    );
  }
}
