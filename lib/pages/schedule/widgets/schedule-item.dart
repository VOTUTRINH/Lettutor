import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/schedule/booking-info.dart';
import 'package:individual_project/pages/schedule/widgets/Info.dart';
import 'package:individual_project/pages/schedule/widgets/text-field-dialog.dart';
import 'package:individual_project/services/schedule.service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleItem extends StatelessWidget {
  ScheduleItem({Key? key, required this.booking}) : super(key: key);
  final BookingInfo booking;

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
                        formatdate(
                            booking.scheduleDetailInfo?.startPeriodTimestamp),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                    Text("1 lesson", style: TextStyle(fontSize: 14))
                  ],
                )),
            Info(),
            Container(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          formatTime(booking
                                  .scheduleDetailInfo?.startPeriodTimestamp) +
                              '-' +
                              formatTime(booking
                                  .scheduleDetailInfo?.endPeriodTimestamp),
                          style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 4, 0, 4),
                          child: button("Cancel", Colors.redAccent, Colors.red,
                              Colors.red, onPressed: () async {
                            final res =
                                await ScheduleService.cancelABookedClass(
                                    booking.id, authProvider.getAccessToken());

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(res['message'].toString())));
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
                          child: Text(booking.studentRequest ?? ''),
                        )
                      ]))
                ],
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.fromLTRB(15, 4, 0, 4),
                child: button(
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
