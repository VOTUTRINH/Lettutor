import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/filter.dart';
import 'package:individual_project/pages/tutors/widgets/tutor-item.dart';
import 'package:individual_project/pages/tutors/widgets/upcoming-lesson.dart';
import 'package:individual_project/services/models/tutor.dart';
import 'package:individual_project/services/respository/tutor-filter.dart';
import 'package:individual_project/services/respository/tutor-repositiory.dart';
import 'package:provider/provider.dart';

class ListTutorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tutorRepository = Provider.of<TutorRepository>(context);
    final tutorFilter = Provider.of<TutorFilter>(context);

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

            // List of tutors sorted by favorite and rating
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tutorRepository.getTutorList().length,
                  itemBuilder: (context, index) {
                    // Sort the tutorList by favorite and rating
                    tutorRepository.getTutorList().sort((a, b) {
                      if (a.isFavorite != b.isFavorite) {
                        return a.isFavorite! ? -1 : 1;
                      } else {
                        return b.rating!.compareTo(a.rating ?? 0);
                      }
                    });

                    // Filter the tutorList by specialties
                    if (tutorFilter.getspecialties() != '') {
                      if (tutorFilter.isValidTutor(
                          tutorRepository.getTutorList()[index])) {
                        return TutorItem(
                            tutor: tutorRepository.getTutorList()[index]);
                      } else {
                        return Container();
                      }
                    }

                    return TutorItem(
                        tutor: tutorRepository.getTutorList()[index]);
                  }),
            ),
          ],
        ));
  }
}
