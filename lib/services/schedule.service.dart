import 'dart:convert';
import 'package:individual_project/models/schedule/booking-info.dart';
import 'package:individual_project/models/schedule/schedule.dart';
import 'package:individual_project/services/base_url.dart';
import 'package:http/http.dart' as http;

class ScheduleService {
  static Future<List<Schedule>> getScheduleByTutorId(
      String token, String tutorId) async {
    final url = Uri.parse(BaseUrl.baseUrl + 'schedule');

    final response = await http.post(url, headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "tutorId": tutorId,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<Schedule> schedules = [];

      schedules.addAll(responseData['data']
          .map<Schedule>((item) => Schedule.fromJson(item))
          .toList());

      return schedules;
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  static Future<bool> bookAClass(
      String scheduleDetailIds, String note, String token) async {
    final url = Uri.parse('${BaseUrl.baseUrl}booking');
    final List<String> list = [scheduleDetailIds];
    final Map<String, dynamic> args = {
      "scheduleDetailIds": list,
    };

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json;encoding=utf-8",
      },
      body: json.encode(args),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<BookingInfo>> getScheduleOrHistory(
      int page, int perPage, int inFuture, String token, String sort) async {
    final url = Uri.parse(
        '${BaseUrl.baseUrl}booking/list/student?page=$page&perPage=$perPage&inFuture=$inFuture&orderBy=meeting&sortBy=$sort');

    final res = await http.get(url, headers: {
      "Authorization": "Bearer $token",
      "Content-type": "application/json;"
    });

    if (res.statusCode == 200) {
      final responseData = json.decode(res.body);
      final listBookingInfo = responseData["data"]["rows"] as List;
      final list = listBookingInfo
          .map((schedule) => BookingInfo.fromJson(schedule))
          .toList();
      return list;
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  static Future<Map<String, Object>> cancelABookedClass(
      String scheduleDetailId, String token) async {
    final url = Uri.parse('${BaseUrl.baseUrl}booking/schedule-detail');
    final Map<String, dynamic> args = {
      "scheduleDetailId": scheduleDetailId,
      "cancelInfo": {"cancelReasonId": 1} // TODO: handle reson cancel
    };

    final response = await http.delete(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
      body: json.encode(args),
    );

    if (response.statusCode == 200) {
      return {
        'isSuccess': true,
        'message': 'Cancel successfully',
      };
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return {
        'isSuccess': false,
        'message': responseData['message'],
      };
    }
  }
}
