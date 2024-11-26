import 'package:intl/intl.dart';

class ApiConstants {
  static const String viaggiaTrenoBasePath =
      "http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno";

  static const String leFrecceBasePath =
      "https://www.lefrecce.it/Channels.Website.BFF.WEB/website";

  static const String findSolutionsUrl = "$leFrecceBasePath/ticket/solutions";

  /// @param {String} name : iniziali della stazione cercata;
  static String autocompleteLeFrecceUrl(String name) {
    return "$leFrecceBasePath/locations/search?name=$name";
  }

  /// @param {String} name : iniziali della stazione cercata;
  static String autocompleteViaggiaTrenoUrl(String name) {
    return "$viaggiaTrenoBasePath/autocompletaStazione/$name";
  }

  /// @param {int} departureLocationId : id della stazione di partenza restituita dall'autocomplete di "leFrecce"
  /// @param {int} arrivalLocationId : id della stazione di partenza restituita dall'autocomplete di "leFrecce"
  static Map<String, dynamic> findSolutionsBody(String depratureLocationId,
      String arrivalLocationId, DateTime departureTime) {
    Map<String, dynamic> body = {
      "departureLocationId": int.parse(depratureLocationId.trim()),
      "arrivalLocationId": int.parse(arrivalLocationId),
      "departureTime": DateFormat("yyyy-MM-ddTHH:mm:ss").format(departureTime),
      "adults": 1,
      "children": 0,
      "criteria": {
        "frecceOnly": false,
        "regionalOnly": false,
        "intercityOnly": false,
        "tourismOnly": false,
        "noChanges": false,
        "order": "DEPARTURE_DATE",
        "offset": 0,
        "limit": 10
      },
      "advancedSearchRequest": {"bestFare": false, "bikeFilter": false}
    };
    return body;
  }

  ///@param {String} departureStation : stazione di partenza nel fromato S02334
  ///@param {String} trainCode : codice treno
  ///@param {String} date : data restituita dalle soluzioni trovate con l'url findSolutionsUrl in millisecondi
  static String trainStatusUrl(
      String departureStation, String trainCode, String dateMills) {
    return "http://www.viaggiatreno.it/infomobilita/resteasy/viaggiatreno/andamentoTreno/$departureStation/$trainCode/$dateMills";
  }
}
