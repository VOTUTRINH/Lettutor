import 'dart:convert';

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
}
