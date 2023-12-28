import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/course/course.dart';
import 'package:individual_project/pages/courses/widgets/list-course.dart';
import 'package:individual_project/services/course.service.dart';
import 'package:provider/provider.dart';

class TabMenuCourses extends StatefulWidget {
  final String outerTab;

  TabMenuCourses({
    required this.outerTab,
    Key? key,
  }) : super(key: key);

  @override
  _TabMenuCoursesState createState() => _TabMenuCoursesState();
}

class _TabMenuCoursesState extends State<TabMenuCourses>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  List<Course> _courses = [];
  bool isLoading = true;
  int page = 1;
  int size = 10;
  getCoureList(String token, int page, int size) async {
    final courses =
        await CourseService.getListCourseWithPagination(page, size, token);
    if (mounted) {
      setState(() {
        _courses = courses;
        isLoading = false;
      });
    }
  }

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
    final authProvider = Provider.of<AuthProvider>(context);
    if (isLoading) {
      getCoureList(authProvider.getAccessToken(), page, size);
    }
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
            height: 450 * (_courses.length * 1.0 ?? 1.0) + 100,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(8),
                  child: ListCourse(
                    title: "",
                    listCourses: _courses,
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
