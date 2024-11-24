import 'package:flutter/material.dart';
import 'package:treni_pendolari/configs/app_theme.dart';
import 'package:treni_pendolari/data/models/station/station_model.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/domain/entities/station/station.dart';
import 'package:treni_pendolari/domain/repositories/autocomplete_repository.dart';
import 'package:treni_pendolari/injection.dart';
import 'package:treni_pendolari/presentation/widgets/app_bar.dart';

class SearchStationPage extends StatefulWidget {
  const SearchStationPage({
    super.key,
    required this.trip,
  });
  final SearchingTrip trip;

  @override
  State<SearchStationPage> createState() => _SearchStationPageState();
}

class _SearchStationPageState extends State<SearchStationPage> {
  final _formKey = GlobalKey<FormState>();
  List<Station> availableStations = [];
  final TextEditingController controllerFrom = TextEditingController();
  final TextEditingController controllerTo = TextEditingController();
  final FocusNode focusFrom = FocusNode();
  final FocusNode focusTo = FocusNode();
  late SearchingTrip _trip;
  bool toInputNeverFocused = true;
  final AutocompleteRepository autocompleteRepository =
      getIt.get<AutocompleteRepository>();
  late FocusNode lastFocusedNode;

  @override
  void initState() {
    super.initState();
    lastFocusedNode = focusFrom;

    focusFrom.addListener(() async {
      if (!focusFrom.hasFocus) {
        await Future.delayed(const Duration(milliseconds: 500));
        _formKey.currentState?.validate();
        toInputNeverFocused = false;
      }
      if (focusFrom.hasFocus) lastFocusedNode = focusFrom;
    });

    focusTo.addListener(() async {
      if (!focusTo.hasFocus && !toInputNeverFocused) {
        await Future.delayed(const Duration(
            milliseconds:
                500)); //altrimenti valida il form prima che vengo inserito il valore se faccio tap si
        _formKey.currentState?.validate();
      }
      if (focusTo.hasFocus) lastFocusedNode = focusTo;
    });

    if (widget.trip.from.name.isNotEmpty) {
      controllerFrom.text = widget.trip.from.name;
    }
    if (widget.trip.to.name.isNotEmpty) {
      controllerTo.text = widget.trip.to.name;
    }
    _trip = widget.trip;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusFrom);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerFrom.dispose();
    controllerTo.dispose();
    focusFrom.dispose();
    focusTo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        showLeading: true,
        height: 50,
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            Navigator.of(context).pop(widget.trip);
          } else {
            Navigator.of(context).pop(_trip);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: _formKey, // Form Key per validazione
          child: Column(
            children: [
              TextFormField(
                focusNode: focusFrom,
                controller: controllerFrom,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value != _trip.from.name) {
                    return "Inserisci una stazione di partenza valida";
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    if (availableStations.isNotEmpty) {
                      controllerFrom.text = availableStations[0].name;
                      _trip = _trip.copyWith(
                          from: StationModel(
                              name: availableStations[0].name,
                              locationId: availableStations[0].locationId,
                              code: ""));
                      FocusScope.of(context).requestFocus(focusTo);
                    } else {
                      toInputNeverFocused = false;
                      _formKey.currentState!.validate();
                      FocusScope.of(context).requestFocus(focusTo);
                    }
                    availableStations = [];
                  });
                },
                onChanged: (value) async {
                  List<Station> stations = await _getStationsByName(value);
                  if (mounted) {
                    setState(() {
                      availableStations = stations;
                    });
                  }
                },
                decoration:
                    const InputDecoration(hintText: "Stazione di partenza")
                        .applyDefaults(AppTheme.theme.inputDecorationTheme)
                        .copyWith(
                          suffixIcon: controllerFrom.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    controllerFrom.clear();
                                    setState(() {
                                      if (focusFrom.hasFocus) {
                                        availableStations = [];
                                      }
                                    }); // Aggiorna la UI dopo aver cancellato il testo
                                  },
                                )
                              : null,
                        ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                focusNode: focusTo,
                controller: controllerTo,
                validator: (value) {
                  if ((value == null ||
                          value.isEmpty ||
                          value != _trip.to.name) &&
                      !toInputNeverFocused) {
                    return "Inserisci una stazione di arrivo valida";
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    if (availableStations.isNotEmpty) {
                      controllerTo.text = availableStations[0].name;
                      _trip = _trip.copyWith(
                          to: StationModel(
                              name: availableStations[0].name,
                              locationId: availableStations[0].locationId,
                              code: ""));
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop(_trip);
                      }
                    } else {
                      _formKey.currentState!.validate();
                    }
                  });
                },
                onChanged: (value) async {
                  List<Station> stations = await _getStationsByName(value);
                  if (mounted) {
                    setState(() {
                      availableStations = stations;
                    });
                  }
                },
                decoration:
                    const InputDecoration(hintText: "Stazione di arrivo")
                        .applyDefaults(AppTheme.theme.inputDecorationTheme)
                        .copyWith(
                          suffixIcon: controllerTo.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    controllerTo.clear();
                                    setState(() {
                                      if (focusTo.hasFocus) {
                                        availableStations = [];
                                      }
                                    }); // Aggiorna la UI dopo aver cancellato il testo
                                  },
                                )
                              : null,
                        ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: availableStations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          setState(() {
                            if (lastFocusedNode == focusFrom) {
                              FocusScope.of(context).requestFocus(focusTo);
                              controllerFrom.text =
                                  availableStations[index].name;
                              _trip = _trip.copyWith(
                                  from: StationModel(
                                      name: availableStations[index].name,
                                      locationId:
                                          availableStations[index].locationId,
                                      code: ""));
                            } else {
                              controllerTo.text = availableStations[index].name;
                              _trip = _trip.copyWith(
                                  to: StationModel(
                                      name: availableStations[index].name,
                                      locationId:
                                          availableStations[index].locationId,
                                      code: ""));

                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).pop(_trip);
                              }
                            }
                            availableStations = [];
                          });
                        },
                        title: Text(availableStations[index].name));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Station>> _getStationsByName(String value) async {
    if (value.length >= 2) {
      return await autocompleteRepository.findStationsByName(value);
    } else {
      return Future.value([]);
    }
  }
}
