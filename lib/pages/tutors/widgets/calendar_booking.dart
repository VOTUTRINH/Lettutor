import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/schedule/schedule.dart';
import 'package:individual_project/models/schedule/schedule_detail.dart';
import 'package:individual_project/services/schedule.service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarBooking extends StatefulWidget {
  CalendarBooking({Key? key, required this.tutorId}) : super(key: key);
  final String tutorId;

  @override
  _CalendarBookingState createState() => _CalendarBookingState();
}

class _CalendarBookingState extends State<CalendarBooking> {
  List<Schedule> _schedules = [];
  List<ScheduleDetails> _schedulesDetails = [];
  bool isLoading = true;
  getSchedulesByTutorId(String token, String tutorId) async {
    List<Schedule> res =
        await ScheduleService.getScheduleByTutorId(token, tutorId);
    res = res.where((schedule) {
      final now = DateTime.now();
      final startTime =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp);

      return startTime.isAfter(now) ||
          (startTime.day == now.day &&
              startTime.month == now.month &&
              startTime.year == now.year);
    }).toList();
    List<ScheduleDetails> schedulesDetails = [];
    res.forEach((schedule) {
      schedulesDetails.addAll(schedule.scheduleDetails ?? []);
    });

    if (mounted) {
      setState(() {
        _schedules = res;
        _schedulesDetails = schedulesDetails;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (isLoading) {
      getSchedulesByTutorId(authProvider.getAccessToken(), widget.tutorId);
    }
    return isLoading
        ? Container(child: Text("Loading...")) //TODO:  custom loading
        : Scaffold(
            appBar: AppBar(title: Text("List Booking")),
            body: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: SfCalendar(
                  view: CalendarView.week,
                  dataSource: SchduleDataSource(_schedulesDetails ?? []),
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.indicator,
                  ),
                  timeSlotViewSettings: TimeSlotViewSettings(
                    timeInterval: Duration(minutes: 30),
                    timeFormat: 'H:mm',
                  ),
                  onTap: (CalendarTapDetails details) {
                    if (details.targetElement == CalendarElement.appointment) {
                      final ScheduleDetails schedule =
                          details.appointments!.first;
                      if (!schedule.isBooked!) {
                        _showNotePopup(context, schedule, authProvider);
                      }
                    }
                  },
                  appointmentBuilder: (BuildContext context,
                      CalendarAppointmentDetails details) {
                    final List<ScheduleDetails> schedules =
                        details.appointments.cast<ScheduleDetails>().toList();

                    return Container(
                      decoration: BoxDecoration(
                          color:
                              (schedules.any((schedule) => schedule.isBooked!))
                                  ? Colors.white
                                  : Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: (schedules.isNotEmpty)
                            ? _buildScheduleList(schedules)
                            : Text("Book",
                                style: TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }

  Widget _buildScheduleList(List<ScheduleDetails> schedules) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: schedules
          .map((schedule) => Text(
                schedule.isBooked! ? "Booked" : "Book",
                style: TextStyle(
                    color: schedule.isBooked! ? Colors.green : Colors.white,
                    fontSize: 10),
              ))
          .toList(),
    );
  }

  void _showNotePopup(BuildContext context, ScheduleDetails schedule,
      AuthProvider authProvider) {
    TextEditingController noteController = TextEditingController(text: '');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Note'),
          content: TextField(
            controller: noteController,
            decoration: InputDecoration(
              hintText: 'Enter your note here...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                bool res = await ScheduleService.bookAClass(
                    schedule.id.toString(),
                    noteController.text,
                    authProvider.getAccessToken());

                if (res) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booked successfully'),
                    ),
                  );

                  setState(() {
                    _schedulesDetails.forEach((element) {
                      if (element.id == schedule.id) {
                        element.isBooked = true;
                      }
                    });
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booked failed'),
                    ),
                  );
                }
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

class SchduleDataSource extends CalendarDataSource {
  SchduleDataSource(List<ScheduleDetails> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.fromMillisecondsSinceEpoch(
        _getMeetingData(index).startPeriodTimestamp);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.fromMillisecondsSinceEpoch(
        _getMeetingData(index).endPeriodTimestamp);
  }

  ScheduleDetails _getMeetingData(int index) {
    final dynamic schedule = appointments![index];
    late final ScheduleDetails scheduleData;
    if (schedule is ScheduleDetails) {
      scheduleData = schedule;
    }

    return scheduleData;
  }
}
