import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:individual_project/pages/courses/widgets/dropdown-input.dart';
import 'package:individual_project/pages/courses/widgets/tab-menu.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';

class CoursesPage extends StatefulWidget {
  CoursesPage({Key? key}) : super(key: key);

  @override
  CoursesPageState createState() => CoursesPageState();
}

class CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    List<String> levels = [
      "Any Level",
      "Beginner",
      "Upper-Beginner",
      "Pre-Intermediate",
      "Upper-Intermediate",
      "Pre-advanced",
      "Advanced",
      "Intermediate"
    ];

    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 25),
                            child: SvgPicture.asset(
                              'assets/images/course.svg',
                              width: 120,
                              height: 120,
                            ),
                          ),
                          Expanded(
                            child: Column(children: [
                              Text("Discover Courses",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 11, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.grey[200],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Course",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                    Text(
                        "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields."),
                    Wrap(
                      children: [
                        DropdownInput(
                            options: levels, hintText: "Selected Level"),
                        DropdownInput(
                            options: levels, hintText: "Selected Level"),
                        DropdownInput(
                            options: levels, hintText: "Selected Level")
                      ],
                    ),
                    TabMenuCourses(outerTab: "My Outer Tab")
                  ],
                ))));
  }
}
