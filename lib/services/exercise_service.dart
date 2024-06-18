import 'dart:convert';

import 'package:ulimagym/configs/constants.dart';
import 'package:http/http.dart' as http;
import '../models/entities/Exercise.dart';

class ExerciseService {
  Future<List<Exercise>?> fetchAll({int? bodyPartId, int? memberId}) async {
    String queryParam =
        (bodyPartId == null ? '' : '?body_part_id=${bodyPartId}') +
            (memberId == null
                ? ''
                : ((bodyPartId == null ? '?' : '&')) + 'member_id=${memberId}');
    String url = "${BASE_URL}exercise/list${queryParam}";
    List<Exercise> exerciseList = [];
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> parsedData = json.decode(response.body);
        exerciseList = parsedData
            .map((bodyPartJson) => Exercise.fromJson(bodyPartJson))
            .toList();
        return exerciseList;
      } else {
        print('ERROORRR!!!');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
  }
}
