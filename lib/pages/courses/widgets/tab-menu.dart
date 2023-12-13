import 'package:flutter/material.dart';
import 'package:individual_project/pages/courses/widgets/course-card.dart';
import 'package:individual_project/pages/courses/widgets/list-course.dart';
import 'package:individual_project/models/course.dart';

class NestedTabBar extends StatefulWidget {
  final String outerTab;

  NestedTabBar({
    required this.outerTab,
    Key? key,
  }) : super(key: key);

  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Course> listCourses = [
      Course(
          id: "1",
          name: "Life in the Internet Age",
          description:
              "Let's discuss how technology is changing the way we live",
          imageUrl:
              "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e",
          level: "Intermediate",
          numberLessons: 9),
      Course(
          id: "1",
          name: "Life in the Internet Age",
          description:
              "Let's discuss how technology is changing the way we live",
          imageUrl:
              "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e",
          level: "Intermediate",
          numberLessons: 9),
    ];
    return Container(
        child: Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Course'),
            Tab(text: 'E-book'),
            Tab(text: 'Interactive E-book')
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
        Container(
            height: 450 * (listCourses.length * 1.0 ?? 1.0) + 100,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(8),
                  child: ListCourse(
                    title: "English For Traveling",
                    listCourses: listCourses,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: Center(child: Text('E-book')),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: Center(child: Text('Interactive E-book')),
                ),
              ],
            ))
      ],
    ));
  }
}
