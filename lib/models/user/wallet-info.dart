class WalletInfo {
  String? id;
  String? userId;
  String? amount;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? bonus;

  WalletInfo({
    this.id,
    this.userId,
    this.amount,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.bonus,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    return WalletInfo(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      amount: json['amount'] ?? '',
      isBlocked: json['isBlocked'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      bonus: json['bonus'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userId'] = userId;
    data['amount'] = amount;
    data['isBlocked'] = isBlocked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['bonus'] = bonus;
    return data;
  }
}
