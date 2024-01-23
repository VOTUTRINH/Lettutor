import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/course/course.dart';
import 'package:individual_project/pages/courses/widgets/list-course.dart';
import 'package:individual_project/services/course.service.dart';
import 'package:provider/provider.dart';

class CourseTab extends StatefulWidget {
  CourseTab({Key? key, this.search, this.isLoading, this.onFinish, this.level})
      : super(key: key);
  String? search;
  String? level;
  bool? isLoading;
  final Function? onFinish;
  @override
  _CourseTabState createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  List<Course> _courses = [];
  int page = 1;
  int size = 10;
  getCoureList(String token, int page, int size) async {
    final courses = await CourseService.getListCourseWithPagination(
        page, size, token,
        q: widget.search ?? "", level: widget.level ?? "");
    if (mounted) {
      setState(() {
        _courses = courses;
        widget.onFinish!();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (widget.isLoading!) {
      getCoureList(authProvider.getAccessToken(), page, size);
    }
    return ListCourse(
      title: "",
      listCourses: _courses,
    );
  }
}
