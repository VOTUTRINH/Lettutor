class FeedBack {
  final String? id;
  String? bookingId;
  final String? userId; // User
  final String? tutorId; // Tutor
  final int? rating;
  final String? content;
  final String? createdAt;
  final String? updatedAt;

  FeedBack(
      {required this.id,
      this.bookingId,
      this.userId,
      this.tutorId,
      this.rating,
      this.content,
      this.createdAt,
      this.updatedAt});

  factory FeedBack.fromJson(Map<String, dynamic> json) {
    return FeedBack(
      id: json['id'],
      bookingId: json['bookingId'],
      userId: json['firstId'],
      tutorId: json['secondId'],
      rating: json['rating'].runtimeType == double
          ? json['rating']
          : double.parse(json['rating'].toString()),
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
