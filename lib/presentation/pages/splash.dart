import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:treni_pendolari/configs/app_images.dart';
import 'package:treni_pendolari/domain/usecases/routine/get_routine.dart';
import 'package:treni_pendolari/domain/usecases/search/first_search.dart';
import 'package:treni_pendolari/presentation/pages/home/home.dart';
import 'package:treni_pendolari/presentation/pages/routine_init/pages/departure.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final GetRoutineUseCase getRoutineUseCase =
      GetIt.instance<GetRoutineUseCase>();
  final FirstSearchUseCase firstSearchUseCase =
      GetIt.instance<FirstSearchUseCase>();

  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.9, // 80% della larghezza dello schermo
                height: MediaQuery.of(context).size.height * 0.4, // 40
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.splashImage),
                        fit: BoxFit.cover)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Treni Pendolari",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black),
            )
          ],
        ));
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    if (getRoutineUseCase.call().isFirstOpening) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => DepaturePage()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage(routineTrips: firstSearchUseCase.call())));
    }
  }
}
