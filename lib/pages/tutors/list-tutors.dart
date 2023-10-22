import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/list-tutors-view.dart';
import 'package:individual_project/pages/tutors/widgets/upcoming-lesson.dart';
import 'package:provider/provider.dart';

class ListTutorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                margin: EdgeInsets.only(top: 70),
                child: Column(
                  children: <Widget>[UpcomingLesson(), ListTutorsView()],
                ))));
  }
}
