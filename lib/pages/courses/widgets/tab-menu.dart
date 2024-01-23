import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/course/course.dart';
import 'package:individual_project/pages/courses/widgets/course-tab.dart';
import 'package:individual_project/pages/courses/widgets/list-course.dart';
import 'package:individual_project/services/course.service.dart';
import 'package:provider/provider.dart';

class TabMenuCourses extends StatefulWidget {
  TabMenuCourses({
    required this.outerTab,
    this.search,
    this.level,
    this.isLoading,
    this.onFinish,
    Key? key,
  }) : super(key: key);

  final String outerTab;
  final String? search;
  final String? level;
  final bool? isLoading;
  final Function? onFinish;

  @override
  _TabMenuCoursesState createState() => _TabMenuCoursesState();
}

class _TabMenuCoursesState extends State<TabMenuCourses>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool isLoading = true;

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
            height: 400 * 10.0,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(8),
                  child: CourseTab(
                      search: widget.search,
                      level: widget.level,
                      isLoading: widget.isLoading,
                      onFinish: widget.onFinish),
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
