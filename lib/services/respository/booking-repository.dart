import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:individual_project/services/models/booking.dart';
import 'package:individual_project/services/models/feedback.dart';

class BookingRepository extends ChangeNotifier {
  List<Booking> bookings = [
    Booking(
        id: '1',
        tutorId: '1',
        userId: '1',
        from: DateTime(2023, 11, 26, 9),
        to: DateTime(2023, 11, 26, 9, 30),
        note: "I want to learn about Flutter",
        isBooked: true),
    Booking(
        id: '2',
        tutorId: '1',
        from: DateTime(2023, 11, 27, 7),
        to: DateTime(2023, 11, 27, 7, 30),
        isBooked: false),
  ];

  getBookingByTutorId(String tutorId) {
    return bookings.where((element) => element.tutorId == tutorId).toList();
  }

  getBookingByUserId(String userId) {
    return bookings
        .where((element) =>
            element.userId == userId && (element.from!.isAfter(DateTime.now())))
        .toList();
  }

  getHistoryBookingByUserId(String userId) {
    return bookings
        .where((element) =>
            element.userId == userId && (element.to!.isBefore(DateTime.now())))
        .toList();
  }

  void add(Booking booking) {
    bookings.add(booking);
    notifyListeners();
  }

  void update(Booking booking) {
    bookings[bookings.indexWhere((element) => element.id == booking.id)] =
        booking;
    notifyListeners();
  }
}
