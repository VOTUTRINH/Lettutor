import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/schedule/booking-info.dart';
import 'package:individual_project/services/user.service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpcomingLesson extends StatefulWidget {
  const UpcomingLesson({Key? key}) : super(key: key);

  @override
  _UpcomingLessonState createState() => _UpcomingLessonState();
}

class _UpcomingLessonState extends State<UpcomingLesson> {
  Duration? totalLessonTime;
  BookingInfo? nextLesson;
  bool isLoading = true;

  void getUpcomingLesson(String token) async {
    final total = await UserService.getTotalHourLesson(token);
    final nextLes = await UserService.getNextLesson(token);

    if (mounted) {
      setState(() {
        totalLessonTime = Duration(minutes: total);
        nextLesson = nextLes;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (isLoading) {
      getUpcomingLesson(authProvider.getAccessToken());
    }
    return Row(children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0C3DDF),
                    Color(0xFF05179D),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Upcoming Lesson",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 251, 253, 253))),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(children: [
                            Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: isLoading
                                          ? Text("...")
                                          : Text(
                                              nextLesson != null
                                                  ? "${DateFormat.yMEd().format(DateTime.fromMillisecondsSinceEpoch(nextLesson!.scheduleDetailInfo!.startPeriodTimestamp))} ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(nextLesson!.scheduleDetailInfo!.startPeriodTimestamp))} - ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(nextLesson!.scheduleDetailInfo!.endPeriodTimestamp))}"
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                    ),
                                    // Expanded(
                                    //     child: Text(
                                    //   this.timeStartIn,
                                    //   style: TextStyle(
                                    //       fontSize: 16, color: Colors.yellow),
                                    // ))
                                  ],
                                ))
                          ]),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Adjust the radius as needed
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.blue,
                              ),
                              Text("Enter Lesson Room",
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        child: Text(
                            totalLessonTime == null
                                ? ''
                                : 'Total lession time is ${covertTotalTime(totalLessonTime as Duration)}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)))
                  ],
                ),
              )))
    ]);
  }

  String covertTotalTime(Duration d) {
    String res = "";
    Duration total = d;
    if (total.inHours > 0) {
      res += "${total.inHours} hours ";
      total = total - Duration(hours: total.inHours);
    }
    if (total.inMinutes > 0) {
      res += "${total.inMinutes} minutes";
      total = total - Duration(minutes: total.inMinutes);
    }

    return res;
  }
}
