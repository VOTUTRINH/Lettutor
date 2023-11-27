import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:individual_project/pages/schedule/widgets/schedule-item.dart';
import 'package:individual_project/services/models/booking-info.dart';
import 'package:individual_project/services/respository/booking-repository.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatelessWidget {
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
    final bookingRepository = Provider.of<BookingRepository>(context);
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                margin: EdgeInsets.only(top: 70),
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
                              'assets/images/calendar.svg',
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
                                    "Schedule",
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
                                          "Here is a list of the sessions you have booked",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                            "You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours",
                                            style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(30, 48, 30, 16),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text(
                                "Latest Book",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              )),
                          Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(children: [
                                TableCell(
                                    child: cell("Name",
                                        Color.fromARGB(255, 233, 225, 225))),
                                TableCell(
                                  child: cell("", Colors.white),
                                ), // A file
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: cell("Page",
                                        Color.fromARGB(255, 233, 225, 225))),
                                TableCell(
                                  child: cell("0", Colors.white),
                                )
                              ]),
                              TableRow(children: [
                                TableCell(
                                    child: cell("Description",
                                        Color.fromARGB(255, 233, 225, 225))),
                                TableCell(
                                  child: cell("", Colors.white),
                                )
                              ])
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                      indent: 16,
                      endIndent: 16,
                    ),
                    ...bookingRepository
                        .getBookingByUserId('1')
                        .map((e) => Container(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            child: ScheduleItem(
                              booking: e,
                            )))
                        .toList()
                  ],
                ))));
  }
}
