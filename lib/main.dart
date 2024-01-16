import 'package:flutter/material.dart';
import 'package:individual_project/global.state/app-provider.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/pages/login/login.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:individual_project/services/respository/account-repository.dart';
import 'package:individual_project/services/respository/booking-repository.dart';
import 'package:individual_project/services/respository/feedback-repository.dart';
import 'package:individual_project/global.state/tutor-filter.dart';
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
  final TutorFilter tutorFilter = new TutorFilter();
  final AuthProvider authProvider = new AuthProvider();
  final AppProvider appProvider = new AppProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => tutorFilter),
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(create: (context) => appProvider)
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
