import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/schedule/booking-info.dart';
import 'package:individual_project/pages/schedule/widgets/schedule-item.dart';
import 'package:individual_project/services/schedule.service.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool isLoading = true;
  List<BookingInfo> _bookingInfos = [];
  int page = 1;
  int perPage = 10;
  late ScrollController _scrollController;
  bool isLoadMore = false;
  String? token;
  String sort = 'asc';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(loadMore);
    super.dispose();
  }

  getListSchedule(int page, int perPage, String token) async {
    final bookingInfos = await ScheduleService.getScheduleOrHistory(
        page, perPage, 1, token, sort);

    setState(() {
      _bookingInfos = bookingInfos;
      isLoading = false;
    });
  }

  void loadMore() async {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      setState(() {
        isLoadMore = true;
        page++;
      });

      try {
        final res = await ScheduleService.getScheduleOrHistory(
            page, perPage, 1, token as String, sort as String);
        if (mounted) {
          setState(() {
            _bookingInfos.addAll(res);
            isLoadMore = false;
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  onScheduleChange() {
    setState(() {
      isLoading = true;
      page = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    setState(() {
      token = authProvider.getAccessToken();
    });

    if (isLoading) {
      getListSchedule(page, perPage, authProvider.getAccessToken());
    }
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            controller: _scrollController,
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
                    Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                      indent: 16,
                      endIndent: 16,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _bookingInfos.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: ScheduleItem(
                            booking: _bookingInfos[index],
                            onScheduleChange: onScheduleChange,
                          ),
                        );
                      },
                    ),
                    if (isLoadMore)
                      const SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ))));
  }
}
