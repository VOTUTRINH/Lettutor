import 'package:flutter/material.dart';
import 'package:individual_project/pages/courses/courses.dart';
import 'package:individual_project/pages/history/history.dart';
import 'package:individual_project/pages/schedule/schedule.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("John Doe"),
            accountEmail: Text("johndoe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
          ...[
            // {
            //   "text": "Recurring Lesson Schedule",
            //   "Icon": Icons.calendar_today_outlined,

            // },
            {
              "text": "Tutor",
              "Icon": Icons.group_outlined,
              "navigate": ListTutorsPage()
            },
            {
              "text": "Schedule",
              "Icon": Icons.schedule,
              "navigate": SchedulePage()
            },
            {
              "text": "History",
              "Icon": Icons.history,
              "navigate": HistoryPage()
            },
            {
              "text": "Courses",
              "Icon": Icons.school,
              "navigate": CoursesPage()
            },
            // {"text": "My Course", "Icon": Icons.book_sharp,  "navigate": ListTutorsPage()},
            // {"text": "Become a tutor", "Icon": Icons.person},
            {"text": "Logout", "Icon": Icons.logout_sharp},
          ]
              .map((item) => ListTile(
                    leading: Icon(item['Icon'] as IconData, color: Colors.blue),
                    title: Text(item['text'] as String),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => item['navigate'] as Widget,
                        ),
                      );
                    },
                  ))
              .toList(),
        ],
      ),
    );
  }
}
