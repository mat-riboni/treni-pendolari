import 'package:flutter/material.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, required this.onClick, required this.trip});
  final Function(SearchingTrip) onClick;
  final SearchingTrip trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                onClick(trip);
              },
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: const Color.fromARGB(255, 10, 66, 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text(
                "Cerca",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ),
      ],
    );
  }
}
