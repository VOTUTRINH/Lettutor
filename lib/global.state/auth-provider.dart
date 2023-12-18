import 'package:flutter/cupertino.dart';
import 'package:individual_project/models/tokens.dart';
import 'package:individual_project/models/user/user-info.dart';

class AuthProvider extends ChangeNotifier {
  late UserInfo userLoggedIn;
  Tokens? tokens;

  void logIn(UserInfo user, Tokens _tokens) {
    userLoggedIn = user;
    tokens = _tokens;
    notifyListeners();
  }

  void setUser(UserInfo user) {
    userLoggedIn = user;
    notifyListeners();
  }

  void logOut() {
    tokens = null;
    notifyListeners();
  }

  String getAccessToken() {
    return tokens!.access.token;
  }
}
