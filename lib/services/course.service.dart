import 'package:individual_project/models/course/category.dart';
import 'package:individual_project/models/course/course.dart';
import 'package:individual_project/services/base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CourseService {
  static Future<List<Course>> getListCourseWithPagination(
    int page,
    int size,
    String token, {
    String q = "",
    String level = "",
  }) async {
    String baseUrl = "${BaseUrl.baseUrl}course?page=$page&size=$size";

    if (q.isNotEmpty) {
      baseUrl += "&q=$q";
    }

    if (level.isNotEmpty) {
      baseUrl += "&level[]=$level";
    }

    final url = Uri.parse(baseUrl);
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final courses = res["data"]["rows"] as List;
      final arr = courses.map((e) => Course.fromJson(e)).toList();
      return arr;
    } else {
      throw Exception('Cannot get list course');
    }
  }

  static Future<List<Category>> getAllCourseCategories(String token) async {
    final url = Uri.parse("${BaseUrl.baseUrl}content-category");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final courses = res["rows"] as List;
      final arr = courses.map((e) => Category.fromJson(e)).toList();
      return arr;
    } else {
      throw Exception('Cannot get list category');
    }
  }

  static Future<Course> getCourseDetail(String courseId, String token) async {
    final url = Uri.parse("${BaseUrl.baseUrl}course/$courseId");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final course = Course.fromJson(res["data"]);
      return course;
    } else {
      throw Exception('Cannot get course detail');
    }
  }
}
