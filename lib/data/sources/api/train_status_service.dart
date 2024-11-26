import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:treni_pendolari/data/sources/api/api_constants.dart';
import 'package:treni_pendolari/domain/entities/train/train.dart';

class TrainStatusService {
  Future<Map<String, dynamic>> getTrainStatus(
      Train train, String dateMills) async {
    final url = Uri.parse(ApiConstants.trainStatusUrl(
        train.originStationCode, train.id, dateMills));
    try {
      final response = await http.get(url);
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
