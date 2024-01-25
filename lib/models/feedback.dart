class FeedBack {
  late String id;
  String? bookingId;
  late String firstId;
  late String secondId;
  late int rating;
  late String content;
  late String createdAt;
  late String updatedAt;
  late FirstInfo firstInfo;

  FeedBack(
      {required this.id,
      this.bookingId,
      required this.firstId,
      required this.secondId,
      required this.rating,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.firstInfo});

  FeedBack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    if (json["rating"].runtimeType == int) {
      rating = json['rating'];
    } else {
      rating = json['rating'].toInt() ?? 5;
    }
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstInfo = FirstInfo.fromJson(json['firstInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['bookingId'] = bookingId;
    data['firstId'] = firstId;
    data['secondId'] = secondId;
    data['rating'] = rating;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['firstInfo'] = firstInfo.toJson();
    return data;
  }
}

class FirstInfo {
  String? avatar;
  late String name;

  FirstInfo({
    this.avatar,
    required this.name,
  });

  FirstInfo.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['avatar'] = avatar;
    data['name'] = name;
    return data;
  }
}
