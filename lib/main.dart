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
import 'package:individual_project/pages/tutors/widgets/video.dart';
import 'package:individual_project/services/models/tutor.dart';
import 'package:individual_project/services/respository/account-repository.dart';
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

  final List<Tutor> tutorList = [
    Tutor(
        userId: "1",
        avatar:
            "https://cdn.tuoitre.vn/thumb_w/730/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756.jpg",
        name: "Nguyen Van A",
        description:
            "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
        specialties: "English for kids,English for Business",
        education: "BA",
        experience: "I have more than 10 years of teaching english experience",
        languages: "English",
        interests:
            "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
        country: "VN",
        video:
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        rating: 2,
        isFavorite: true),
    Tutor(
      userId: "2",
      avatar:
          "https://cdn.tuoitre.vn/thumb_w/730/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756.jpg",
      name: "Nguyen Van B",
      specialties:
          "English for kids,English for Business,Conversational,STARTERS",
      education: "BA",
      experience: "I have more than 10 years of teaching english experience",
      languages: "English",
      interests:
          "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
      country: "VN",
      video:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      rating: 5,
      isFavorite: false,
    ),
    Tutor(
        userId: "3",
        avatar:
            "https://cdn.tuoitre.vn/thumb_w/730/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756.jpg",
        name: "Nguyen Van C",
        specialties:
            "English for kids,English for Business,Conversational,STARTERS",
        education: "BA",
        experience: "I have more than 10 years of teaching english experience",
        languages: "English",
        interests:
            "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
        country: "VN",
        video:
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        rating: 4,
        isFavorite: true),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => accountRepository),
        Provider(create: (context) => tutorList)
      ],
      child: MaterialApp(
        title: 'Name',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: ListTutorsPage(),
      ),
    );
  }
}
