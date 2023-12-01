import 'package:flutter/material.dart';
import 'package:individual_project/services/models/booking.dart';
import 'package:individual_project/services/models/tutor.dart';
import 'package:individual_project/services/respository/booking-repository.dart';
import 'package:individual_project/services/respository/tutor-repositiory.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarBooking extends StatefulWidget {
  CalendarBooking({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;

  @override
  _CalendarBookingState createState() => _CalendarBookingState();
}

class _CalendarBookingState extends State<CalendarBooking> {
  @override
  Widget build(BuildContext context) {
    final bookingRepository = Provider.of<BookingRepository>(context);

    return Scaffold(
      appBar: AppBar(title: Text("List Booking")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: SfCalendar(
            view: CalendarView.week,
            dataSource: BookingDataSource(
                bookingRepository.getBookingByTutorId(widget.tutor.userId!) ??
                    []),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            ),
            timeSlotViewSettings: TimeSlotViewSettings(
              timeInterval: Duration(minutes: 30),
              timeFormat: 'H:mm',
            ),
            onTap: (CalendarTapDetails details) {
              if (details.targetElement == CalendarElement.appointment) {
                final Booking booking = details.appointments!.first;
                if (!booking.isBooked!) {
                  _showNotePopup(context, booking, bookingRepository);
                }
              }
            },
            appointmentBuilder:
                (BuildContext context, CalendarAppointmentDetails details) {
              final List<Booking> bookings =
                  details.appointments.cast<Booking>().toList();

              return Container(
                decoration: BoxDecoration(
                    color: (bookings.any((booking) =>
                            booking.isBooked! || booking.isBlocked!))
                        ? Colors.white
                        : Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: (bookings.isNotEmpty)
                      ? _buildBookingList(bookings)
                      : Text("Book", style: TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList(List<Booking> bookings) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: bookings
          .map((booking) => Text(
                booking.isBlocked!
                    ? "Block"
                    : booking.isBooked!
                        ? "Booked"
                        : "Book",
                style: TextStyle(
                  fontSize: 10,
                  color: booking.isBlocked!
                      ? Colors.grey
                      : booking.isBooked!
                          ? Colors.green
                          : Colors.white,
                ),
              ))
          .toList(),
    );
  }

  void _showNotePopup(
    BuildContext context,
    Booking booking,
    BookingRepository bookingRepository,
  ) {
    String note = booking.note ?? '';
    TextEditingController noteController =
        TextEditingController(text: booking.note);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Note'),
          content: TextField(
            controller: noteController,
            onChanged: (value) {
              note = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter your note here...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                booking.note = note ?? '';
                booking.userId = '1';
                booking.isBooked = true;
                bookingRepository.update(booking);

                Navigator.of(context).pop();
              },
              child: Text('Book'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class BookingDataSource extends CalendarDataSource {
  BookingDataSource(List<Booking> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from!;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to!;
  }

  Booking _getMeetingData(int index) {
    final dynamic booking = appointments![index];
    late final Booking bookingData;
    if (booking is Booking) {
      bookingData = booking;
    }

    return bookingData;
  }
}
