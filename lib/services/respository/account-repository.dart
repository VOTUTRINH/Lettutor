import 'package:flutter/cupertino.dart';
import 'package:individual_project/models/account.dart';

class AccountRepository extends ChangeNotifier {
  final List<Account> accounts = [];

  void add(Account account) {
    accounts.add(account);
    notifyListeners();
  }

  bool isExistedAccount(String email, String password) {
    return accounts.any(
      (element) => element.email == email && element.password == password,
    );
  }
}
