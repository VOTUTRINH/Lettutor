import 'package:individual_project/models/schedule/schedule_detail.dart';
import 'package:individual_project/models/tutor/tutor-info.dart';
import 'package:individual_project/models/tutor/tutor.dart';
import 'package:individual_project/models/user/user-info.dart';

class Schedule {
  late String id;
  late String tutorId;
  late String startTime;
  late String endTime;
  late int startTimestamp;
  late int endTimestamp;
  late String createdAt;
  bool isBooked = false;
  List<ScheduleDetails> scheduleDetails = [];
  Tutor? tutorInfo;

  Schedule({
    required this.id,
    required this.tutorId,
    required this.startTime,
    required this.endTime,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.createdAt,
    required this.isBooked,
    required this.scheduleDetails,
    this.tutorInfo,
  });

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    createdAt = json['createdAt'];
    isBooked = json['isBooked'] ?? false;
    if (json['scheduleDetails'] != null) {
      scheduleDetails = [];
      json['scheduleDetails'].forEach((v) {
        scheduleDetails.add(ScheduleDetails.fromJson(v));
      });
    }

    tutorInfo =
        json['tutorInfo'] != null ? Tutor.fromJson(json['tutorInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['tutorId'] = tutorId;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['startTimestamp'] = startTimestamp;
    data['endTimestamp'] = endTimestamp;
    data['createdAt'] = createdAt;
    data['isBooked'] = isBooked;
    data['scheduleDetails'] = scheduleDetails.map((v) => v.toJson()).toList();
    data['tutorInfo'] = tutorInfo?.toJson();
    return data;
  }
}

class Tutor {
  late String id;
  late String userId;
  String? video;
  late String bio;
  late String education;
  late String experience;
  late String profession;
  UserInfo? user;
  String? accent;
  String? targetStudent;
  late String interests;
  late String languages;
  late String specialties;
  String? resume;
  late bool isActivated;
  bool? isNative;
  late String createdAt;
  late String updatedAt;
  bool? isFavorite;
  int? avgRating;
  late int price;
  String? name;
  String? avatar;

  Tutor({
    required this.id,
    required this.userId,
    this.video,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    required this.user,
    this.accent,
    this.targetStudent,
    required this.interests,
    required this.languages,
    required this.specialties,
    this.resume,
    required this.isActivated,
    this.isNative,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite,
    this.avgRating,
    required this.price,
  });

  Tutor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'] ?? "";
    video = json['video'];
    bio = json['bio'] ?? "";
    education = json['education'] ?? "";
    experience = json['experience'] ?? "";
    profession = json['profession'] ?? "";
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'] ?? "";
    languages = json['languages'] ?? "";
    specialties = json['specialties'] ?? "";
    resume = json['resume'];
    isActivated = json['isActivated'];
    isNative = json['isNative'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isFavorite = json['isFavorite'];
    avgRating = json['avgRating'] != null ? json['avgRating'].toInt() : 0;
    price = json['price'] ?? 0;
    user = json["User"] != null ? UserInfo.fromJson(json['User']) : null;
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userId'] = userId;
    data['video'] = video;
    data['bio'] = bio;
    data['education'] = education;
    data['experience'] = experience;
    data['profession'] = profession;
    data['accent'] = accent;
    data['targetStudent'] = targetStudent;
    data['interests'] = interests;
    data['languages'] = languages;
    data['specialties'] = specialties;
    data['resume'] = resume;
    data['isActivated'] = isActivated;
    data['isNative'] = isNative;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isFavorite'] = isFavorite;
    data['avgRating'] = avgRating;
    data['price'] = price;
    data['user'] = user?.toJson();
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
