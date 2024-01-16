import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/list-tutors-view.dart';
import 'package:individual_project/pages/tutors/widgets/upcoming-lesson.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';

class ListTutorsPage extends StatefulWidget {
  const ListTutorsPage({Key? key}) : super(key: key);

  @override
  _ListTutorsState createState() => _ListTutorsState();
}

class _ListTutorsState extends State<ListTutorsPage> {
  late ScrollController _scrollController;
  bool isLoadMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  onLoadMoreChange() {
    setState(() {
      isLoadMore = false;
    });
  }

  void loadMore() async {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      setState(() {
        isLoadMore = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                child: Column(
                  children: <Widget>[
                    UpcomingLesson(),
                    ListTutorsView(
                        isLoadMore: isLoadMore,
                        onLoadMoreChange: onLoadMoreChange),
                    isLoadMore
                        ? const SizedBox(
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(),
                  ],
                ))));
  }

  @override
  void dispose() {
    _scrollController.removeListener(loadMore);
    super.dispose();
  }
}
