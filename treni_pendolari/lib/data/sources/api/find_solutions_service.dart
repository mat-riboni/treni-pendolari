import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:treni_pendolari/data/sources/api/api_constants.dart';

class FindSolutionsService {
  Future<Map<String, dynamic>> findSolutions(String departureLocationId,
      String arrivalLocationId, DateTime departureTime) async {
    final url = Uri.parse(ApiConstants.findSolutionsUrl);
    Map<String, dynamic> body = ApiConstants.findSolutionsBody(
        departureLocationId, arrivalLocationId, departureTime);
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept':
                'application/json', // Questa intestazione potrebbe essere importante
          },
          body: jsonEncode(body));
      return jsonDecode(response.body);
    } catch (e) {
      print("find solution service error");
      return Future.value({});
    }
  }
}
