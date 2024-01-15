import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/schedule/booking-info.dart';
import 'package:individual_project/pages/history/widgets/history-item.dart';
import 'package:individual_project/services/respository/booking-repository.dart';
import 'package:individual_project/services/schedule.service.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  Widget cell(value, background) {
    return Container(
        decoration: BoxDecoration(
          color: background, // Set the background color here
        ),
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Text(value));
  }

  bool isLoading = true;
  List<BookingInfo> _bookingInfos = [];
  int page = 1;
  int perPage = 10;
  late ScrollController _scrollController;
  bool isLoadMore = false;
  String? token;
  String sort = 'desc';

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
        page, perPage, 0, token, sort);

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
            page, perPage, 1, token as String, sort);
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
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _bookingInfos.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: HistoryItem(
                            booking: _bookingInfos[index],
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
