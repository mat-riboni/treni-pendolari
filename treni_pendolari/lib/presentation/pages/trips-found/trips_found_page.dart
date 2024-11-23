import 'package:flutter/material.dart';
import 'package:treni_pendolari/configs/app_colors.dart';
import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/presentation/pages/trips-found/response_trip_list.dart';
import 'package:treni_pendolari/presentation/widgets/app_bar.dart';

class TripsFoundPage extends StatelessWidget {
  const TripsFoundPage(
      {super.key, required this.responseList, this.searchingTrip});
  final List<ResponseTrip> responseList;
  final SearchingTrip? searchingTrip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(showLeading: true),
      backgroundColor: AppColors.backgroundColor,
      body: ResponseTripList(responseList: responseList),
    );
  }
}
