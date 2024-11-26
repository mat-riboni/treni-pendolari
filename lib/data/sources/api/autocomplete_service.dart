import 'dart:convert';

import 'package:treni_pendolari/data/sources/api/api_constants.dart';
import 'package:http/http.dart' as http;

class AutocompleteService {
  Future<List<Map<String, dynamic>>> autocompleteLeFrecce(String name) async {
    final url = Uri.parse(ApiConstants.autocompleteLeFrecceUrl(name));

    try {
      final response = await http.get(url);

      final List<dynamic> decodedResponse = jsonDecode(response.body);

      return decodedResponse.cast<Map<String, dynamic>>();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> autocompleteViaggiaTreno(String name) async {
    final url = Uri.parse(ApiConstants.autocompleteViaggiaTrenoUrl(name));

    try {
      final response = await http.get(url);
      return response.body;
    } catch (e) {
      rethrow;
    }
  }
}
