import 'package:flutter/material.dart';
import 'package:individual_project/services/models/course.dart';
import 'package:individual_project/services/models/topic.dart';

class CoursesRepository extends ChangeNotifier {
  List<Course> courses = [
    Course(
        id: "1",
        name: "Life in the Internet Age",
        description: "Let's discuss how technology is changing the way we live",
        imageUrl:
            "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e",
        level: "Intermediate",
        numberLessons: 9,
        topics: [
          Topic(
              title: "Foods You Love",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYour%20Job.pdf"),
          Topic(
              title: "Your Job",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileArtificial%20Intelligence%20(AI).pdf"),
          Topic(
              title: "Playing and Watching Sports",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSocial%20Media.pdf"),
          Topic(
              title: "The Best Pet",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileInternet%20Privacy.pdf"),
          Topic(
              title: "Having Fun in Your Free Time",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileLive%20Streaming.pdf"),
          Topic(
              title: "Your Daily Routine",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileCoding.pdf"),
          Topic(
              title: "Childhood Memories",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileTechnology%20Transforming%20Healthcare.pdf"),
          Topic(
              title: "Your Family Members",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileSmart%20Home%20Technology.pdf"),
          Topic(
              title: "Your Hometown",
              pdfUrl:
                  "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileRemote%20Work%20-%20A%20Dream%20Job.pdf"),
        ]),
  ];

  getListCourses() {
    return courses;
  }
}
