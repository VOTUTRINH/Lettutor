import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/schedule/booking-info.dart';
import 'package:individual_project/pages/schedule/widgets/Info.dart';
import 'package:individual_project/pages/schedule/widgets/text-field-dialog.dart';
import 'package:individual_project/services/schedule.service.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:provider/provider.dart';

class ScheduleItem extends StatefulWidget {
  ScheduleItem({Key? key, required this.booking, this.onScheduleChange})
      : super(key: key);
  final BookingInfo booking;
  final Function? onScheduleChange;

  @override
  _ScheduleItemState createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  formatdate(date) {
    return DateFormat.yMEd().format(DateTime.fromMillisecondsSinceEpoch(date));
  }

  formatTime(date) {
    return DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(date));
  }

  Widget cell(value, background) {
    return Container(
        decoration: BoxDecoration(
          color: background,
        ),
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Text(value));
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    final base64Decoded = base64.decode(base64.normalize(
        widget.booking.studentMeetingLink!.split("token=")[1].split(".")[1]));
    final urlObject = utf8.decode(base64Decoded);
    final jsonRes = json.decode(urlObject);
    final String roomId = jsonRes['room'];

    return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 215, 209, 209),
        ),
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        formatdate(widget
                            .booking.scheduleDetailInfo?.startPeriodTimestamp),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                    Text("1 lesson", style: TextStyle(fontSize: 14))
                  ],
                )),
            Info(
                tutor: widget
                    .booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!),
            Container(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          formatTime(widget.booking.scheduleDetailInfo
                                  ?.startPeriodTimestamp) +
                              '-' +
                              formatTime(widget.booking.scheduleDetailInfo
                                  ?.endPeriodTimestamp),
                          style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 4, 0, 4),
                          child: button("Cancel", Colors.redAccent, Colors.red,
                              Colors.red, onPressed: () async {
                            final now = DateTime.now();
                            final start = DateTime.fromMillisecondsSinceEpoch(
                                widget.booking.scheduleDetailInfo!
                                    .startPeriodTimestamp);
                            if (start.isAfter(now) &&
                                now.difference(start).inHours.abs() >= 2) {
                              final res =
                                  await ScheduleService.cancelABookedClass(
                                      widget.booking.id!,
                                      authProvider.getAccessToken());

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(res['message'].toString())));
                              widget.onScheduleChange!();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "You can only cancel a class 2 hours before the class starts.")));
                            }
                          }))
                    ],
                  ),
                  Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Column(children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Color.fromARGB(255, 215, 208, 208)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Request for lesson", softWrap: true),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: TextFieldDialog(
                                      link: 'Edit Request',
                                    )),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                          alignment: Alignment.topLeft,
                          child: Text(widget.booking.studentRequest ??
                              'Currently there are no requests for this class. Please write down any requests for the teacher.'),
                        )
                      ]))
                ],
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.fromLTRB(15, 4, 0, 4),
                child: isActiveGoToMeeting(widget.booking)
                    ? button("Go to meeting", Colors.grey[100], Colors.blue,
                        Colors.blue, onPressed: () async {
                        if (isActiveGoToMeeting(widget.booking)) {
                          var jitsiMeet = JitsiMeet();
                          final options = JitsiMeetConferenceOptions(
                              room: roomId,
                              serverURL: "https://meet.lettutor.com");
                          await jitsiMeet.join(options);
                        }
                      })
                    : button(
                        "Go to meeting",
                        Color.fromARGB(255, 214, 206, 206),
                        Color.fromARGB(255, 167, 161, 160),
                        Colors.grey))
          ],
        ));
  }

  Widget button(text, overlayColor, borderColor, textColor, {onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(overlayColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
            side: BorderSide(
              color: borderColor,
              width: 1.0,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }

  isActiveGoToMeeting(BookingInfo bookingInfo) {
    final now = DateTime.now();
    final start = DateTime.fromMillisecondsSinceEpoch(
        bookingInfo.scheduleDetailInfo!.startPeriodTimestamp);
    return (now.day == start.day &&
        now.month == start.month &&
        now.year == start.year);
  }
}
