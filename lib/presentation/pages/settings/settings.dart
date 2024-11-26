import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:treni_pendolari/domain/entities/routine/routine.dart';
import 'package:treni_pendolari/domain/usecases/routine/get_routine.dart';
import 'package:treni_pendolari/presentation/widgets/app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GetRoutineUseCase getRoutineUseCase = GetIt.instance<GetRoutineUseCase>();
  late Routine routine;

  @override
  void initState() {
    super.initState();
    routine = getRoutineUseCase.call();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: BasicAppBar(
          showLeading: true,
          title: Text(
            "Impostazioni",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Center(
          child: Text("Implementare!"),
        ));
  }
}
