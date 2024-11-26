import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:treni_pendolari/data/models/routine/routine_model.dart';
import 'package:treni_pendolari/data/models/routine/routine_trip_model.dart';
import 'package:treni_pendolari/domain/entities/routine/routine.dart';
import 'package:treni_pendolari/domain/entities/routine/routine_trip.dart';
import 'package:treni_pendolari/domain/usecases/routine/get_routine.dart';
import 'package:treni_pendolari/domain/usecases/routine/save_routine.dart';
import 'package:treni_pendolari/presentation/pages/home/home.dart';
import 'package:treni_pendolari/presentation/pages/routine_init/widgets/routine_form.dart';
import 'package:treni_pendolari/presentation/widgets/app_bar.dart';

class ReturnPage extends StatefulWidget {
  const ReturnPage({super.key});

  @override
  State<ReturnPage> createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  final GetRoutineUseCase getRoutineUseCase =
      GetIt.instance<GetRoutineUseCase>();

  final SaveRoutineUseCase saveRoutineUseCase =
      GetIt.instance<SaveRoutineUseCase>();

  late final Routine routine;

  @override
  void initState() {
    super.initState();
    routine = getRoutineUseCase.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppBar(
            showLeading: true,
            title: Text(
              "Imposta Routine",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 30),
            )),
        body: RoutineForm(
          title: "Ritorno:",
          firstLabel: "In genere torno da:",
          secondLabel: "Circa alle ore:",
          thirdLabel: "La mia destinazione è:",
          nextAction: () => {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()))
          },
          skip: _skip,
          onFormSubmit: _saveRoutine,
        ));
  }

  void _saveRoutine(RoutineTrip trip) async {
    print("------------------------");
    print(trip.from);
    print(trip.fromId);
    print(trip.fromCode);
    print(trip.to);
    print(trip.toId);
    print(trip.toCode);
    print("------------------------");
    final Routine newRoutine = RoutineModel(routine.daparture, trip, false, "");
    await saveRoutineUseCase.call(newRoutine);
  }

  void _skip() {
    _saveRoutine(RoutineTripModel(
        from: "",
        fromId: "",
        fromCode: "",
        to: "",
        toId: "",
        toCode: "",
        departureTime: ""));
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
  }
}
