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
        from: DateTime(2023, 11, 30, 9),
        to: DateTime(2023, 11, 30, 9, 30),
        note: "I want to learn about Flutter",
        isBooked: true),
    Booking(
        id: '2',
        tutorId: '1',
        from: DateTime(2023, 12, 3, 7),
        to: DateTime(2023, 12, 3, 7, 30),
        isBooked: false),
    Booking(
        id: '3',
        tutorId: '1',
        from: DateTime(2023, 12, 3, 8),
        to: DateTime(2023, 12, 3, 8, 30),
        isBooked: false),
  ];

  getNextBoookingByUserId(String userId) {
    DateTime now = DateTime.now();
    List<Booking> upcomingBookings = bookings
        .where((booking) => booking.from!.isAfter(now) && booking.isBooked!)
        .toList();

    if (upcomingBookings.isEmpty) {
      return null;
    }
    upcomingBookings.sort((a, b) => a.from!.compareTo(b.from!));
    return upcomingBookings.first;
  }

  getNextLessonTime(String userId) {
    Booking? booking = getNextBoookingByUserId(userId);
    if (booking == null) {
      return null;
    }
    return booking.from!.toString();
  }

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
