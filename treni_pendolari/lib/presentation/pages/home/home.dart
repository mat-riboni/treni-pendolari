import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:treni_pendolari/configs/app_colors.dart';
import 'package:treni_pendolari/domain/entities/search/response_trip.dart';
import 'package:treni_pendolari/domain/entities/search/searching_trip.dart';
import 'package:treni_pendolari/domain/usecases/search/search_trip.dart';
import 'package:treni_pendolari/presentation/pages/home/expand_search_button.dart';

import 'package:treni_pendolari/presentation/pages/home/form_block.dart';
import 'package:treni_pendolari/presentation/pages/home/home_response_list.dart';
import 'package:treni_pendolari/presentation/pages/trips-found/trips_found_page.dart';
import 'package:treni_pendolari/presentation/widgets/app_page_route_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final SearchTripUseCase searchTripUseCase =
      GetIt.instance<SearchTripUseCase>();

  List<ResponseTrip> searchResult = [];
  SearchingTrip? _trip;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 5, right: 5, bottom: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.train,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Cerca Treni",
                                      style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600)
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      FormBlock(
                        fromController: _fromController,
                        toController: _toController,
                        dateTimePickerController: _dateTimeController,
                        onClickSearch: _onClickSearch,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: HomeResponseList(
                    responseList: searchResult,
                    trip: _trip,
                  )),
          ],
        ),
        bottomNavigationBar: searchResult.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 2),
                child: Container(
                    height: 50,
                    color: AppColors.backgroundColor,
                    child: ExpandSearchButton(
                      responseList: searchResult,
                      searchingTrip: _trip,
                    )),
              )
            : Container(
                height: 1,
                color: Colors.transparent,
              ));
  }

  void _onClickSearch(SearchingTrip trip) async {
    if (trip.from.name.isNotEmpty || trip.to.name.isNotEmpty) {
      setState(() {
        searchResult = [];
        _isLoading = true;
      });
      List<ResponseTrip> response = await searchTripUseCase.call(trip);
      setState(() {
        searchResult = response;
        _trip = trip;
        _isLoading = false;
      });
      Navigator.of(context).push(AppPageRouteBuilder(TripsFoundPage(
        responseList: searchResult,
        searchingTrip: _trip,
      )));
    }
  }
}
