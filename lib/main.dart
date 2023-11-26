import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:individual_project/pages/courses/course-detail.dart';
import 'package:individual_project/pages/courses/courses.dart';
import 'package:individual_project/pages/courses/topic-detail.dart';
import 'package:individual_project/pages/history/history.dart';
import 'package:individual_project/pages/login/login.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:individual_project/pages/schedule/schedule.dart';
import 'package:individual_project/pages/tutors/tutor-detail.dart';
import 'package:individual_project/pages/tutors/widgets/calendar_booking.dart';
import 'package:individual_project/pages/tutors/widgets/video.dart';
import 'package:individual_project/services/models/tutor.dart';
import 'package:individual_project/services/respository/account-repository.dart';
import 'package:individual_project/services/respository/tutor-filter.dart';
import 'package:individual_project/services/respository/tutor-repositiory.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final accountRepository = new AccountRepository();

  final tutorRepository = new TutorRepository();

  final TutorFilter tutorFilter = new TutorFilter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => accountRepository),
        ChangeNotifierProvider(create: (context) => tutorRepository),
        ChangeNotifierProvider(create: (context) => tutorFilter),
      ],
      child: MaterialApp(
        title: 'Name',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: ListTutorsPage(),
      ),
    );
  }
}
