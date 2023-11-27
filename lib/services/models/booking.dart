class Booking {
  final String? id;
  final String? tutorId;
  String? userId;
  final DateTime? from;
  final DateTime? to;
  bool? isBooked;
  final bool? isBlocked;
  String? note;
  Booking(
      {this.id,
      this.tutorId,
      this.userId,
      this.from,
      this.to,
      this.isBooked,
      this.note,
      this.isBlocked = false});
}
