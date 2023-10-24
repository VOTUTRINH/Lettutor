import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/filter.dart';
import 'package:individual_project/pages/tutors/widgets/tutor-item.dart';
import 'package:individual_project/pages/tutors/widgets/upcoming-lesson.dart';
import 'package:provider/provider.dart';

class ListTutorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(30, 33, 30, 49),
        child: Column(
          children: [
            Filter(),
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                alignment: Alignment.topLeft,
                child: Text(
                  "Recommended Tutors",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
            TutorItem(
              userId: "1",
              avatar: "avd",
              name: "Tring",
              country: "VN",
              description:
                  "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
            )
          ],
        ));
  }
}
