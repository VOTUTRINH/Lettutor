import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:individual_project/pages/courses/course-detail.dart';
import 'package:individual_project/pages/courses/courses.dart';
import 'package:individual_project/pages/history/history.dart';
import 'package:individual_project/pages/login.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:individual_project/pages/schedule/schedule.dart';
import 'package:individual_project/pages/tutors/tutor-detail.dart';
import 'package:individual_project/pages/tutors/widgets/video.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Name',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: CourseDetailPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random idea:'),
          Text(appState.current.asLowerCase),
        ],
      ),
    );
  }
}
