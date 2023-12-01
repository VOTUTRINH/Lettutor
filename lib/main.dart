import 'package:flutter/material.dart';
import 'package:individual_project/pages/login/login.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:individual_project/services/respository/account-repository.dart';
import 'package:individual_project/services/respository/booking-repository.dart';
import 'package:individual_project/services/respository/courses-repository.dart';
import 'package:individual_project/services/respository/feedback-repository.dart';
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
  final feedbackRepository = new FeedbackRepository();
  final bookingRepository = new BookingRepository();
  final coursesRepository = new CoursesRepository();
  final TutorFilter tutorFilter = new TutorFilter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => accountRepository),
        ChangeNotifierProvider(create: (context) => tutorRepository),
        ChangeNotifierProvider(create: (context) => tutorFilter),
        ChangeNotifierProvider(create: (context) => feedbackRepository),
        ChangeNotifierProvider(create: (context) => bookingRepository),
        ChangeNotifierProvider(create: (context) => coursesRepository),
      ],
      child: MaterialApp(
        title: 'Name',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: LoginPage(),
      ),
    );
  }
}
