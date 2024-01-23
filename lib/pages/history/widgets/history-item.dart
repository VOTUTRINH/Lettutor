import 'package:flutter/material.dart';
import 'package:individual_project/models/schedule/booking-info.dart';
import 'package:individual_project/pages/schedule/widgets/Info.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem({Key? key, required this.booking}) : super(key: key);
  final BookingInfo booking;

  Widget cell(value, background) {
    return Container(
        decoration: BoxDecoration(
          color: background, // Set the background color here
        ),
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Text(value));
  }

  Widget button(text, overlayColor, borderColor, textColor) {
    return ElevatedButton(
      onPressed: () {
        // Add your cancel button action here
        print('Cancel button pressed');
      },
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

  @override
  Widget build(BuildContext context) {
    formatdate(date) {
      return DateFormat.yMEd()
          .format(DateTime.fromMillisecondsSinceEpoch(date));
    }

    formatTime(date) {
      return DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(date));
    }

    getNumberOfDaysAgo(date) {
      final days = (DateTime.now().millisecondsSinceEpoch - date) / 86400000;
      if (days > 365) {
        return "${(days / 365).floor()} year ago";
      } else if (days > 30) {
        return "${(days / 30).floor()} month ago";
      } else if (days > 7) {
        return "${(days / 7).floor()} week ago";
      } else {
        return "${days.floor() > 0 ? days.floor() : 1} day ago";
      }
    }

    return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Color.fromARGB(
              255, 215, 209, 209), // Set the background color here
        ),
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            formatdate(booking
                                .scheduleDetailInfo!.startPeriodTimestamp),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700)),
                        Text(
                            getNumberOfDaysAgo(booking
                                .scheduleDetailInfo!.startPeriodTimestamp),
                            style: TextStyle(fontSize: 14))
                      ],
                    )
                  ],
                )),
            Info(tutor: booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!),
            Container(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
                margin: EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(children: [
                  Wrap(children: [
                    Text(
                        "Lesson Time: ${formatTime(booking.scheduleDetailInfo!.startPeriodTimestamp)}-${formatTime(booking.scheduleDetailInfo!.startPeriodTimestamp)}",
                        style: TextStyle(fontSize: 20))
                  ])
                ])),
            Container(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Color.fromARGB(255, 215, 208, 208)),
                            child: Row(
                              children: [
                                Text("Request for lesson"),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Text(booking.studentRequest ??
                              'No request for lesson'),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Color.fromARGB(255, 215, 208, 208)),
                            child: Row(
                              children: [
                                Text("Review from tutor"),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Text(booking.tutorReview ??
                              'No review from tutor yet'),
                        )
                      ]))
                ],
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // show popup
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text('Add a Rating',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // show popup
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text('Report',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
