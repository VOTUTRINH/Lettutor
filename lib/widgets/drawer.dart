import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/user/user-info.dart';
import 'package:individual_project/pages/courses/courses.dart';
import 'package:individual_project/pages/history/history.dart';
import 'package:individual_project/pages/profile/profile.dart';
import 'package:individual_project/pages/schedule/schedule.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:individual_project/widgets/avatar.dart';
import 'package:provider/provider.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserInfo user = authProvider.userLoggedIn;
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            onDetailsPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            ),
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: CircularImage(imageUrl: user.avatar)),
          ),
          ...[
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
