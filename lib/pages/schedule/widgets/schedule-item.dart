import 'package:flutter/material.dart';
import 'package:individual_project/pages/schedule/widgets/Info.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:provider/provider.dart';

class ScheduleItem extends StatelessWidget {
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
                    Text("Sun, 29 Oct 23",
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
                      Text("01:30 - 01:55", style: TextStyle(fontSize: 18)),
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 4, 0, 4),
                          child: button("Cancel", Colors.redAccent, Colors.red,
                              Colors.red))
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
                                InkWell(
                                  onTap: () {
                                    // show popup
                                  },
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text('Edit Request',
                                        style: TextStyle(color: Colors.blue)),
                                  ),
                                )
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Text("Vo Tu Trinhhhhhhhhhhhhhhh"),
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
}
