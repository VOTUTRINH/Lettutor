import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:individual_project/pages/courses/topic-detail.dart';
import 'package:individual_project/services/models/course.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

class CourseDetailPage extends StatelessWidget {
  Course course = Course(
      id: "1",
      name: "Life in the Internet Age",
      description: "Let's discuss how technology is changing the way we live",
      imageUrl:
          "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e",
      level: "Intermediate",
      numberLessons: 9);

  List<String> topics = [
    "Foods You Love",
    "Your Job",
    "Playing and Watching Sports",
    "The Best Pet",
    "Having Fun in Your Free Time",
    "Your Daily Routine",
    "Childhood Memories",
    "Your Family Members",
    "Your Hometown",
    "Shopping Habits"
  ];

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

  @override
  Widget build(BuildContext context) {
    Widget topicCard(index, content) {
      return Container(
          height: 140,
          padding: EdgeInsets.only(left: 12, right: 12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopicDetailPage(),
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
                    content,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ));
    }

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: Container(
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
                              this.course.imageUrl,
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
                                    this.course.name,
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
                                    this.course.description,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue),
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
                              "answer":
                                  "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor",
                            },
                            {
                              "question": "What will you be able to do",
                              "answer":
                                  "This course covers vocabulary at the CEFR A2 level. You will build confidence while learning to speak about a variety of common, everyday topics. In addition, you will build implicit grammar knowledge as your tutor models correct answers and corrects your mistakes.",
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
                                    child: Wrap(
                                        children: [Text(e['answer'] ?? '')]))
                              ])),
                          title("Experience Level"),
                          Row(
                            children: [
                              Icon(Icons.group_add_outlined,
                                  color: Colors.blue),
                              SizedBox(width: 5),
                              Text(course.level,
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
                          ...topics
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
