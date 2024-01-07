import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/course/course.dart';
import 'package:individual_project/models/course/topic.dart';
import 'package:individual_project/pages/courses/topic-detail.dart';
import 'package:individual_project/services/course.service.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

class CourseDetailPage extends StatefulWidget {
  CourseDetailPage({Key? key, this.courseId}) : super(key: key);
  String? courseId;

  @override
  State<CourseDetailPage> createState() => _CourseDetailPage();
}

class _CourseDetailPage extends State<CourseDetailPage> {
  Course? _course = null;
  bool isLoading = true;

  getCourseDetail(String token, String courseId) async {
    final course = await CourseService.getCourseDetail(courseId, token);
    if (mounted) {
      setState(() {
        _course = course;
        isLoading = false;
      });
    }
  }

  Widget title(content) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 16, bottom: 16),
      child: Text(
        content,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget topicCard(index, Topic content) {
    return Container(
        height: 140,
        padding: EdgeInsets.only(left: 12, right: 12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopicDetailPage(
                  course: _course!,
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey, width: 1)),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(index.toString() + '.'),
                Text(
                  content.name,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (isLoading) {
      getCourseDetail(authProvider.getAccessToken(), widget.courseId!);
    }

    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: (isLoading)
                ? Container(child: Text("isLoading"))
                : Container(
                    padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                    child: Column(children: [
                      Container(
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
                                  _course!.imageUrl,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                padding: EdgeInsets.all(28),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        _course!.name,
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
                                      margin: EdgeInsets.only(bottom: 24),
                                      child: Text(
                                        _course!.description,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue),
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 15, 20, 15),
                                                  child: Text("Discover",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16)),
                                                )))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              title("Overview"),
                              ...[
                                {
                                  "question": "Why take this course",
                                  "answer": _course?.reason ?? '',
                                },
                                {
                                  "question": "What will you be able to do",
                                  "answer": _course?.purpose ?? ''
                                }
                              ].map((e) => Column(children: [
                                    Row(children: [
                                      Icon(
                                        Icons.question_mark_outlined,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 3),
                                      Text(e['question'] ?? '',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ]),
                                    Container(
                                        padding: EdgeInsets.only(left: 35),
                                        margin: EdgeInsets.only(bottom: 14),
                                        child: Wrap(children: [
                                          Text(e['answer'] ?? '')
                                        ]))
                                  ])),
                              title("Experience Level"),
                              Row(
                                children: [
                                  Icon(Icons.group_add_outlined,
                                      color: Colors.blue),
                                  SizedBox(width: 5),
                                  Text(_course!.level,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              title("Course Length"),
                              Row(
                                children: [
                                  Icon(Icons.book_outlined, color: Colors.blue),
                                  SizedBox(width: 5),
                                  Text("10 topics",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              title("List Topics"),
                              ..._course!.topics
                                  .asMap()
                                  .entries
                                  .map((content) =>
                                      topicCard(content.key + 1, content.value))
                                  .toList()
                            ],
                          )),
                    ]))));
  }
}
