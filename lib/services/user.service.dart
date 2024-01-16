import 'dart:convert';

import 'package:individual_project/models/schedule/booking-info.dart';
import 'package:individual_project/models/user/learning-topic.dart';
import 'package:individual_project/models/user/test-preparation.dart';
import 'package:individual_project/models/user/user-info.dart';
import 'package:individual_project/services/base_url.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<UserInfo> getUserInfo(String token) async {
    final url = Uri.parse(BaseUrl.baseUrl + 'user/info');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final data = responseData.containsKey('user')
          ? responseData['user']
          : responseData;
      final userInfo = UserInfo.fromJson(data);
      return userInfo;
    } else {
      final responseData = json.decode(response.body);
      throw Exception(responseData['message']);
    }
  }

  static getTotalHourLesson(String token) async {
    final url = Uri.parse(BaseUrl.baseUrl + 'call/total');
    final res = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      final resData = json.decode(res.body);
      return resData["total"];
    } else {
      return null;
    }
  }

  static Future<BookingInfo?> getNextLesson(String token) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final url = Uri.parse(BaseUrl.baseUrl + 'booking/next');
    final res = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      final resData = json.decode(res.body);
      final listData = resData["data"] as List;
      List<BookingInfo> lessons =
          listData.map((e) => BookingInfo.fromJson(e)).toList();
      lessons.sort((a, b) => a.scheduleDetailInfo!.startPeriodTimestamp
          .compareTo(b.scheduleDetailInfo!.startPeriodTimestamp));

      lessons = lessons
          .where((e) => e.scheduleDetailInfo!.startPeriodTimestamp > now)
          .toList();

      return !lessons.isEmpty ? lessons[0] : null;
    } else {
      throw Exception(json.decode(res.body)["message"]);
    }
  }

  static Future<List<LearnTopic>> getAllLearningTopic(String token) async {
    final url = Uri.parse('${BaseUrl.baseUrl}learn-topic');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body) as List;
      final allTopics = jsonRes.map((e) => LearnTopic.fromJson(e)).toList();
      return allTopics;
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  static Future<List<TestPreparation>> getAllTestPreparation(
      String token) async {
    final url = Uri.parse('${BaseUrl.baseUrl}test-preparation');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body) as List;
      final allTestPreparation =
          jsonRes.map((e) => TestPreparation.fromJson(e)).toList();
      return allTestPreparation;
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  static Future<UserInfo?> updateUserInfo(
      String token,
      String name,
      String country,
      String birthday,
      String level,
      List<String> learnTopics,
      List<String> testPreparations) async {
    Map<String, dynamic> args = {
      'name': name,
      'country': country,
      'birthday': birthday,
      'level': level,
      'learnTopics': learnTopics,
      'testPreparations': testPreparations,
    };

    final url = Uri.parse('${BaseUrl.baseUrl}user/info');

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;encoding=utf-8',
      },
      body: json.encode(args),
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final user = UserInfo.fromJson(jsonRes["user"]);
      return user;
    } else {
      return null;
    }
  }

  static Future<bool> uploadAvatar(String path, String token) async {
    final url = Uri.parse('${BaseUrl.baseUrl}user/uploadAvatar');
    final request = http.MultipartRequest("POST", url);

    final img = await http.MultipartFile.fromPath("avatar", path);

    request.files.add(img);
    request.headers.addAll({"Authorization": 'Bearer $token'});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
