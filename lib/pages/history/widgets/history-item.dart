import 'package:flutter/material.dart';
import 'package:individual_project/pages/schedule/widgets/Info.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:individual_project/models/booking.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem({Key? key, required this.booking}) : super(key: key);
  final Booking booking;

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
      return DateFormat('EEE, d MMM yy').format(date);
    }

    formatTime(date) {
      return DateFormat('H:mm').format(date);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatdate(this.booking.from),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                    Text("1 day ago", style: TextStyle(fontSize: 14))
                  ],
                )),
            Info(),
            Container(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
                margin: EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(color: Colors.white),
                child: Wrap(children: [
                  Text(
                      "Lesson Time: " +
                          formatTime(this.booking.from) +
                          '-' +
                          formatTime(this.booking.to),
                      style: TextStyle(fontSize: 20))
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
                          child: Text(this.booking.note ?? 'No note'),
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
                          child: Text("No Review"),
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
