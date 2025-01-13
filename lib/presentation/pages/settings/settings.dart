import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:treni_pendolari/domain/entities/routine/routine.dart';
import 'package:treni_pendolari/domain/usecases/routine/get_routine.dart';
import 'package:treni_pendolari/presentation/pages/routine_init/pages/departure.dart';
import 'package:treni_pendolari/presentation/pages/routine_init/pages/return.dart';
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
    return DepaturePage();
  }
}
