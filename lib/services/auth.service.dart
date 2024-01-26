import 'dart:convert';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/tokens.dart';

import 'package:individual_project/models/user/user-info.dart';
import 'package:individual_project/models/user/user.dart';
import 'package:individual_project/services/base_url.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, Object>> register(
      User user, AuthProvider authProvider) async {
    try {
      var url = Uri.parse(BaseUrl.baseUrl + 'auth/register');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
            'source': 'null'
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseData = json.decode(response.body);
        final tokens = Tokens.fromJson(responseData["tokens"]);
        final userInfo = UserInfo.fromJson(responseData["user"]);
        authProvider.logIn(userInfo, tokens);
        return {
          'isSuccess': true,
          'message':
              'Register successfully, check your email to activate your account'
        };
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'isSuccess': false,
          'message': responseData['message'],
        };
      }
    } on Error catch (_, error) {
      return {
        'isSuccess': false,
        'message': error.toString(),
      };
    }
  }

  static Future<Map<String, Object>> login(
      User user, AuthProvider authProvider) async {
    try {
      var url = Uri.parse(BaseUrl.baseUrl + 'auth/login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        final tokens = Tokens.fromJson(responseData["tokens"]);
        final userInfo = UserInfo.fromJson(responseData["user"]);
        authProvider.logIn(userInfo, tokens);
        return {
          'isSuccess': true,
          'message': 'Login successfully',
        };
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'isSuccess': false,
          'message': responseData['message'],
        };
      }
    } on Error catch (_, error) {
      return {
        'isSuccess': false,
        'message': error.toString(),
      };
    }
  }

  static Future<Map<String, Object>> loginWithGoogle(
      String accessToken, AuthProvider authProvider) async {
    try {
      var url = Uri.parse('${BaseUrl.baseUrl}auth/google');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'access_token': accessToken,
          }));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        final tokens = Tokens.fromJson(responseData["tokens"]);
        final userInfo = UserInfo.fromJson(responseData["user"]);
        authProvider.logIn(userInfo, tokens);
        return {
          'isSuccess': true,
          'message': 'Login successfully',
        };
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {
          'isSuccess': false,
          'message': responseData['message'],
        };
      }
    } on Error catch (_, error) {
      return {
        'isSuccess': false,
        'message': error.toString(),
      };
    }
  }

  static Future<bool> forgotPassword(String email) async {
    final response = await http
        .post(Uri.parse("${BaseUrl.baseUrl}user/forgotPassword"), body: {
      'email': email,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }
}
