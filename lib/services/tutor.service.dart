import 'dart:convert';
import 'package:individual_project/models/tutor/tutor-info.dart';
import 'package:individual_project/models/tutor/tutor.dart';
import 'package:individual_project/services/base_url.dart';
import 'package:http/http.dart' as http;

class TutorService {
  static Future<List<TutorInfo>> getTutors(
      String token, int perPage, int page) async {
    final url =
        Uri.parse(BaseUrl.baseUrl + 'tutor/more?perPage=$perPage&page=$page');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      List<dynamic> tutors = responseData['tutors']['rows'];
      final listTutors =
          tutors.map((tutor) => TutorInfo.fromJson(tutor)).toList();

      return listTutors;
    } else {
      final responseData = json.decode(response.body);
      print(jsonDecode);
      throw Exception(responseData['message']);
    }
  }

  static Future<Tutor> getTutorById(String token, String id) async {
    final url = Uri.parse(BaseUrl.baseUrl + 'tutor/$id');

    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final tutor = Tutor.fromJson(responseData);
      return tutor;
    } else {
      final responseData = json.decode(response.body);
      throw Exception(responseData['message']);
    }
  }

  static Future<List<TutorInfo>> searchTutor(
    int page,
    int perPage,
    String token, {
    String search = "",
    List<String> specialties = const [],
  }) async {
    final Map<String, dynamic> args = {
      "page": page,
      "perPage": perPage,
      "search": search,
      "filters": {
        "specialties": specialties,
      },
    };

    final url = Uri.parse(BaseUrl.baseUrl + 'tutor/search');

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json;encoding=utf-8",
      },
      body: json.encode(args),
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final List<dynamic> tutors = jsonRes["rows"];
      return tutors.map((tutor) => TutorInfo.fromJson(tutor)).toList();
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  static addAndRemoveTutorFavorite(String tutorId, String token) async {
    final url = Uri.parse(BaseUrl.baseUrl + 'user/manageFavoriteTutor');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'tutorId': tutorId,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
