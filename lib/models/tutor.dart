import 'package:flutter/material.dart';
import 'package:individual_project/models/booking.dart';

class Tutor {
  final String userId;
  final String? avatar;
  final String? name;
  final String? description;
  final String? education;
  final String? specialties;
  final String? video;
  final String? experience;
  final String? languages;
  final String? interests;
  final String? country;
  final int? rating;
  bool? isFavorite;
  final List<Booking>? bookings;
  final List<Feedback>? feedbacks;

  Tutor({
    required this.userId,
    this.avatar,
    this.name,
    this.description,
    this.education,
    this.specialties,
    this.rating,
    this.video,
    this.experience,
    this.languages,
    this.interests,
    this.country,
    this.isFavorite,
    this.bookings,
    this.feedbacks,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      userId: json['userId'] ?? json['id'],
      avatar: json['avatar'],
      name: json['name'],
      description: json['bio'],
      specialties: json['specialties'],
      rating: json['rating'],
      isFavorite: json['isFavorite'],
    );
  }

  factory Tutor.fromJson2(Map<String, dynamic> json) {
    return Tutor(
      userId: json['User']['id'],
      avatar: json['User']['avatar'],
      name: json['User']['name'],
      country: json['User']['country'],
      description: json['bio'],
      specialties: json['specialties'],
      rating: json['rating'],
      video: json['video'],
      experience: json['experience'],
      languages: json['languages'],
      interests: json['interests'],
      isFavorite: json['isFavorite'],
    );
  }
}
