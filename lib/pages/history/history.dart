import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:individual_project/pages/history/widgets/history-item.dart';
import 'package:individual_project/pages/schedule/widgets/schedule-item.dart';
import 'package:individual_project/services/models/booking-info.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  Widget cell(value, background) {
    return Container(
        decoration: BoxDecoration(
          color: background, // Set the background color here
        ),
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Text(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: SvgPicture.asset(
                              'assets/images/history.svg',
                              width: 120,
                              height: 120,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "History",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 8.4),
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.grey,
                                          width: 4.0,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "The following is a list of lessons you have attended",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                            "You can review the details of the lessons you have attended",
                                            style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                    // TODO; define list and pass data
                    Container(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: HistoryItem())
                  ],
                ))));
  }
}
