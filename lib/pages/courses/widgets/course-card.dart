import 'package:flutter/material.dart';
import 'package:individual_project/models/course/course.dart';
import 'package:individual_project/pages/courses/course-detail.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({required this.course, Key? key}) : super(key: key);

  final Course course;
  @override
  State<CourseCard> createState() => _CourseCard();
}

class _CourseCard extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(
              courseId: widget.course.id,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.14),
              offset: Offset(0, 4),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                widget.course.imageUrl,
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.fromLTRB(24, 24, 24, 9.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      widget.course.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      widget.course.description,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      Text(widget.course.level), // TODO: handle level
                      SizedBox(
                        width: 5,
                      ),
                      Text(widget.course.topics.length.toString()),
                      SizedBox(
                        width: 3,
                      ),
                      Text("Lessons"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
