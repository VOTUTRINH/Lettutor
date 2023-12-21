import 'dart:convert';

import 'package:individual_project/models/schedule/booking-info.dart';
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
      final userInfo = UserInfo.fromJson(responseData);
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
}
