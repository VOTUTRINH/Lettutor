import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/list-tutors-view.dart';
import 'package:individual_project/pages/tutors/widgets/upcoming-lesson.dart';
import 'package:individual_project/services/respository/tutor-filter.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

class ListTutorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TutorFilter tutorFilter = new TutorFilter();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => tutorFilter),
        ],
        child: Scaffold(
            appBar: AppBar(title: AppBarCustom()),
            endDrawer: DrawerCustom(),
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                    child: Column(
                      children: <Widget>[UpcomingLesson(), ListTutorsView()],
                    )))));
  }
}
