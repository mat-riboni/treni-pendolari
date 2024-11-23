import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:treni_pendolari/data/models/routine/routine_model.dart';
import 'package:treni_pendolari/data/models/routine/routine_trip_model.dart';
import 'package:treni_pendolari/domain/entities/routine/routine.dart';
import 'package:treni_pendolari/domain/entities/routine/routine_trip.dart';
import 'package:treni_pendolari/domain/usecases/routine/save_routine.dart';
import 'package:treni_pendolari/presentation/pages/home/home.dart';
import 'package:treni_pendolari/presentation/pages/routine_init/pages/return.dart';
import 'package:treni_pendolari/presentation/pages/routine_init/widgets/routine_form.dart';
import 'package:treni_pendolari/presentation/widgets/app_bar.dart';

class DepaturePage extends StatelessWidget {
  DepaturePage({super.key});
  final SaveRoutineUseCase saveRoutineUseCase =
      GetIt.instance<SaveRoutineUseCase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppBar(
            showLeading: false,
            title: Text(
              "Imposta Routine",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 30),
            )),
        body: RoutineForm(
          title: "Andata:",
          firstLabel: "In genere parto da:",
          secondLabel: "Circa alle ore:",
          thirdLabel: "La mia destinazione è:",
          nextAction: () async {
            await Future.delayed(const Duration(
                milliseconds:
                    200)); //Altrimenti non riesce a salvare prima di andare alla pagina dopo
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const ReturnPage()));
          },
          skip: _skip,
          onFormSubmit: _saveRoutine,
        ));
  }

  void _saveRoutine(RoutineTrip trip) {
    final Routine routine = RoutineModel(
        trip,
        RoutineTripModel(
            from: "", fromId: "", to: "", toId: "", departureTime: ""),
        true,
        "");
    saveRoutineUseCase(routine);
  }

  void _skip(BuildContext context) {
    _saveRoutine(RoutineTripModel(
        from: "", fromId: "", to: "", toId: "", departureTime: ""));
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
  }
}
