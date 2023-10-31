import 'package:flutter/material.dart';
import 'package:individual_project/pages/courses/widgets/course-card.dart';
import 'package:individual_project/services/models/course.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({Key? key, this.title, required this.listCourses})
      : super(key: key);

  final String? title;
  final List<Course> listCourses;
  @override
  State<ListCourse> createState() => _ListCourse();
}

class _ListCourse extends State<ListCourse> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Visibility(
              visible: widget.title != null,
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.title!,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ))),
          Container(
            child: Wrap(
              children: [
                ...widget.listCourses
                    .map((e) => CourseCard(course: e))
                    .toList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
