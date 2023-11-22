import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingLesson extends StatelessWidget {
  // TODO: Set it is input
  final timeNextLesson = "Thu, 26 Oct 23 03:30 - 03:55 ";
  final timeStartIn = "(starts in 81:42:07)";
  @override
  Widget build(BuildContext context) {
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
                                      child: Text(
                                        this.timeNextLesson,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
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
                        child: Text("Total lesson time is 507 hours 55 minutes",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)))
                  ],
                ),
              )))
    ]);
  }
}
