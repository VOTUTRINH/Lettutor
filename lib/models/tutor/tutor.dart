import 'package:individual_project/models/user/user-info.dart';

class Tutor {
  final String? video;
  final String? bio;
  final String? education;
  final String? experience;
  final String? profession;
  final String? accent;
  final String? targetStudent;
  final String? interests;
  final String? languages;
  final String? specialties;
  double? rating;
  final bool? isNative;
  final String? youtubeVideoId;
  final UserInfo? user;
  bool? isFavorite;
  double? avgRating;
  final int? totalFeedback;

  Tutor({
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.rating,
    this.isNative,
    this.youtubeVideoId,
    this.user,
    this.isFavorite,
    this.avgRating,
    this.totalFeedback,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      video: json['video'],
      bio: json['bio'],
      education: json['education'],
      experience: json['experience'],
      profession: json['profession'],
      accent: json['accent'],
      targetStudent: json['targetStudent'],
      interests: json['interests'],
      languages: json['languages'],
      specialties: json['specialties'],
      rating: json['rating'] != null ? json['rating'].toDouble() : 0,
      isNative: json['isNative'],
      youtubeVideoId: json['youtubeVideoId'],
      user: UserInfo.fromJson(json['User']),
      isFavorite: json['isFavorite'],
      avgRating: json['avgRating'] != null ? json['avgRating'].toDouble() : 0,
      totalFeedback: json['totalFeedback'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    data['rating'] = rating;
    data['isNative'] = isNative;
    data['youtubeVideoId'] = youtubeVideoId;
    data['User'] = user?.toJson();
    data['isFavorite'] = isFavorite;
    data['avgRating'] = avgRating;
    data['totalFeedback'] = totalFeedback;
    return data;
  }
}
