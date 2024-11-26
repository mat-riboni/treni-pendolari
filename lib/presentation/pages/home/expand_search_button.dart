import 'package:flutter/material.dart';
import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/presentation/pages/trips_found/trips_found_page.dart';
import 'package:treni_pendolari/presentation/widgets/app_page_route_builder.dart';

class ExpandSearchButton extends StatelessWidget {
  const ExpandSearchButton(
      {super.key, required this.responseList, this.searchingTrip});
  final List<ResponseTrip> responseList;
  final SearchingTrip? searchingTrip;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(AppPageRouteBuilder(TripsFoundPage(
          responseList: responseList,
        )));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 10, 66, 4),
          minimumSize: const Size(200, 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      child: const Center(
        child: Text(
          "Dettagli Ricerca",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
