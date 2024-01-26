import 'package:flutter/material.dart';
import 'package:individual_project/models/schedule/schedule_detail.dart';

class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? googleMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  String? cancelNote;
  bool? isDeleted;
  bool? isTrial;
  int? convertedLesson;
  int? cancelReasonId;
  // bool showRecordUrl = true;
  // List<String> studentMaterials = [];
  ScheduleDetails? scheduleDetailInfo;

  BookingInfo(
      {this.createdAtTimeStamp,
      this.updatedAtTimeStamp,
      this.id,
      this.userId,
      this.scheduleDetailId,
      this.tutorMeetingLink,
      this.studentMeetingLink,
      this.studentRequest,
      this.tutorReview,
      this.scoreByTutor,
      this.createdAt,
      this.updatedAt,
      this.recordUrl,
      this.isDeleted,
      this.cancelReasonId
      // required this.showRecordUrl,
      // required this.studentMaterials,
      // this.scheduleDetailInfo,
      });

  BookingInfo.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'] ?? 0;
    updatedAtTimeStamp = json['updatedAtTimeStamp'] ?? 0;
    id = json['id'] ?? "";
    userId = json['userId'] ?? "";
    scheduleDetailId = json['scheduleDetailId'] ?? "";
    tutorMeetingLink = json['tutorMeetingLink'] ?? "";
    studentMeetingLink = json['studentMeetingLink'] ?? "";
    studentRequest = json['studentRequest'] ?? "";
    tutorReview = json['tutorReview'] ?? "";
    scoreByTutor = json['scoreByTutor'] ?? 0;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    recordUrl = json['recordUrl'] ?? "";
    isDeleted = json['isDeleted'] ?? false;
    cancelReasonId = json['cancelReasonId'];
    // showRecordUrl = json["showRecordUrl"] ?? true;
    // studentMaterials = json["studentMaterials"] != null
    //     ? json["studentMaterials"].cast<String>()
    //     : [];
    scheduleDetailInfo = json["scheduleDetailInfo"] != null
        ? ScheduleDetails.fromJson(json["scheduleDetailInfo"])
        : null;

    googleMeetingLink = json['googleMeetingLink'] ?? "";
    cancelNote = json['cancelNote'] ?? "";
    isTrial = json['isTrial'] ?? false;
    convertedLesson = json['convertedLesson'] ?? 0;
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
    data['cancelReasonId'] = cancelReasonId;
    return data;
  }
}
