import 'package:flutter/material.dart';
import 'package:individual_project/models/schedule/schedule_detail.dart';

class BookingInfo {
  late int createdAtTimeStamp;
  late int updatedAtTimeStamp;
  late String id;
  late String userId;
  late String scheduleDetailId;
  late String tutorMeetingLink;
  late String studentMeetingLink;
  String? googleMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  late String createdAt;
  late String updatedAt;
  String? recordUrl;
  String? cancelNote;
  late bool isDeleted;
  late bool isTrial;
  int? convertedLesson;
  // bool showRecordUrl = true;
  // List<String> studentMaterials = [];
  ScheduleDetails? scheduleDetailInfo;

  BookingInfo({
    required this.createdAtTimeStamp,
    required this.updatedAtTimeStamp,
    required this.id,
    required this.userId,
    required this.scheduleDetailId,
    required this.tutorMeetingLink,
    required this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    required this.createdAt,
    required this.updatedAt,
    this.recordUrl,
    required this.isDeleted,
    // required this.showRecordUrl,
    // required this.studentMaterials,
    // this.scheduleDetailInfo,
  });

  BookingInfo.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    userId = json['userId'];
    scheduleDetailId = json['scheduleDetailId'];
    tutorMeetingLink = json['tutorMeetingLink'];
    studentMeetingLink = json['studentMeetingLink'];
    studentRequest = json['studentRequest'];
    tutorReview = json['tutorReview'];
    scoreByTutor = json['scoreByTutor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    recordUrl = json['recordUrl'];
    isDeleted = json['isDeleted'];
    // showRecordUrl = json["showRecordUrl"] ?? true;
    // studentMaterials = json["studentMaterials"] != null
    //     ? json["studentMaterials"].cast<String>()
    //     : [];
    scheduleDetailInfo = json["scheduleDetailInfo"] != null
        ? ScheduleDetails.fromJson(json["scheduleDetailInfo"])
        : null;

    googleMeetingLink = json['googleMeetingLink'];
    cancelNote = json['cancelNote'];
    isTrial = json['isTrial'] ?? false;
    convertedLesson = json['convertedLesson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAtTimeStamp'] = createdAtTimeStamp;
    data['updatedAtTimeStamp'] = updatedAtTimeStamp;
    data['id'] = id;
    data['userId'] = userId;
    data['scheduleDetailId'] = scheduleDetailId;
    data['tutorMeetingLink'] = tutorMeetingLink;
    data['studentMeetingLink'] = studentMeetingLink;
    data['studentRequest'] = studentRequest;
    data['tutorReview'] = tutorReview;
    data['scoreByTutor'] = scoreByTutor;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['recordUrl'] = recordUrl;
    data['isDeleted'] = isDeleted;
    // data['showRecordUrl'] = showRecordUrl;
    // data['studentMaterials'] = studentMaterials;
    data['scheduleDetailInfo'] =
        scheduleDetailInfo != null ? scheduleDetailInfo!.toJson() : null;
    data['googleMeetingLink'] = googleMeetingLink;
    data['cancelNote'] = cancelNote;
    data['isTrial'] = isTrial;
    data['convertedLesson'] = convertedLesson;
    return data;
  }
}
