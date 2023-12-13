class Account {
  final int accountId;
  final String email;
  final String password;
  Account(this.accountId, this.email, this.password);
  Map<String, dynamic> toMap() {
    return {'accountId': accountId, 'email': email, 'password': password};
  }

  @override
  String toString() {
    return 'Account{accountId: $accountId, email: $email, password: $password}';
  }
}
