import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:individual_project/models/course/course.dart';
import 'package:individual_project/pages/courses/widgets/topic_pdf.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

class TopicDetailPage extends StatefulWidget {
  TopicDetailPage({Key? key, required this.course}) : super(key: key);
  Course course;
  @override
  State<TopicDetailPage> createState() => _TopicDetailPage();
}

class _TopicDetailPage extends State<TopicDetailPage> {
  int topicActive = 0;

  void setActiveTopic(int index) {
    setState(() {
      topicActive = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                child: Column(children: [
                  Image.network(
                    widget.course.imageUrl,
                  ),
                  Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(bottom: 22),
                            child: Text(
                              widget.course.name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              widget.course.description,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 26, bottom: 11),
                            child: Text(
                              "List Topics",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                          ),
                          ...widget.course.topics
                              .asMap()
                              .entries
                              .map((e) => (InkWell(
                                    onTap: () {
                                      setActiveTopic(e.key + 1);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TopicPdfViewer(
                                            url: e.value.nameFile,
                                            title: e.value.name,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (e.key + 1 == this.topicActive)
                                              ? Color.fromARGB(
                                                  255, 212, 195, 195)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      margin: EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  20, 10, 20, 10),
                                              child:
                                                  Text(e.key.toString() + '.')),
                                          Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 10),
                                              child: Text(e.value.name + '.'))
                                        ],
                                      ),
                                    ),
                                  )))
                              .toList()
                        ],
                      ))
                ]))));
  }
}
