class BookingInfo {
  late String id;
  late String userId;
  String? studentRequest;
  String? tutorReview;
  String? createdAt;
  bool? isDeleted;
  bool? showRecordUrl = true;

  BookingInfo({
    required this.id,
    required this.userId,
    this.studentRequest,
    this.tutorReview,
    this.createdAt,
    this.isDeleted,
    this.showRecordUrl,
  });
}
