import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/tutor/tutor.dart';
import 'package:individual_project/pages/tutors/widgets/calendar_booking.dart';
import 'package:individual_project/pages/tutors/widgets/feedback.dart';
import 'package:individual_project/pages/tutors/widgets/video.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:individual_project/pages/tutors/widgets/star_rating.dart';
import 'package:individual_project/models/feedback.dart';
import 'package:individual_project/services/tutor.service.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';

/// Stateful widget to fetch and then display video content
class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({super.key, required this.tutorId, this.feedbacks});
  final String tutorId;
  final List<FeedBack>? feedbacks;
  @override
  _TutorDetailPage createState() => _TutorDetailPage();
}

class _TutorDetailPage extends State<TutorDetailPage> {
  rederListTag(String tags) {
    if (tags != null) {
      List<String> listTag = tags.split(",");
      return Container(
        margin: EdgeInsets.only(top: 10, left: 10, bottom: 20),
        alignment: Alignment.topLeft,
        child: Wrap(
          children: listTag
              .map((tag) => Container(
                    margin: EdgeInsets.all(4),
                    padding:
                        EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 169, 201, 232)),
                    child: Text(
                      tag,
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ))
              .toList(), // Create a Tag widget for each tag
        ),
      );
    } else {
      return Container();
    }
  }

  title(String _title) {
    if (_title != null) {
      return Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(bottom: 8.5),
          child: Text(_title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)));
    }
  }

  Tutor _tutor = Tutor();

  findTutorById(String token, String id) async {
    Tutor tutor = await TutorService.getTutorById(token, id);
    if (mounted) {
      setState(() {
        _tutor = tutor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    findTutorById(authProvider.getAccessToken(), widget.tutorId);

    // final imageCountry =
    //     'icons/flags/png/${_tutor.user!.country!.toLowerCase()}.png';
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: (_tutor.user != null)
                ? Container(
                    padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircularImage(
                              imageUrl: _tutor.user!.avatar!,
                              size: 110,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Text(
                                      _tutor.user!.name,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    )),
                                    StarRating(rating: _tutor.avgRating!),
                                    Row(
                                      children: [
                                        // Image.asset(
                                        //   imageCountry,
                                        //   package: 'country_icons',
                                        //   width: 22,
                                        //   height: 22,
                                        // ),
                                        SizedBox(width: 5),
                                        Text(_tutor.user!.country!)
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        ),
                        //TODO: favorite + reporting
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() async {
                                    final isFavorite = await TutorService
                                        .addAndRemoveTutorFavorite(
                                            _tutor.user!.id,
                                            authProvider.getAccessToken());
                                    _tutor.isFavorite = isFavorite;
                                  });
                                },
                                child: Icon(
                                  _tutor.isFavorite!
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _tutor.isFavorite!
                                      ? Colors.red
                                      : Colors.blue,
                                  size: 36.0,
                                ),
                              )
                            ]),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 15, 50, 0),
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(_tutor.bio ?? "")),

                        VideoPlayerScreen(link: _tutor.video),
                        Container(
                            margin: EdgeInsets.only(bottom: 20, top: 35),
                            child: Column(
                              children: [
                                title("Education"),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin:
                                        EdgeInsets.only(bottom: 7, left: 15),
                                    child: Text(_tutor.education!,
                                        style: TextStyle(fontSize: 15)))
                              ],
                            )),
                        title("Languages"),
                        rederListTag(_tutor.languages!),
                        title("Specialties"),
                        rederListTag(_tutor.specialties!),

                        ...[
                          {"title": "Interests", "content": _tutor.interests!},
                          {
                            "title": "Teaching experience",
                            "content": _tutor.experience
                          }
                        ]
                            .map((e) => Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: [
                                    title(e['title'] as String),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            bottom: 7, left: 15),
                                        child: Text(e['content'] as String,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)))
                                  ],
                                )))
                            .toList(),
                        Container(
                          alignment: Alignment.topLeft,
                          child: title("Other review"),
                        ),
                        ...widget.feedbacks!
                            .getRange(0, 10)
                            .map((e) => FeedBackUI(feedback: e))
                            .toList(),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CalendarBooking(tutor: _tutor),
                                    ),
                                  );
                                },
                                child: Text("List booking",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)))) // List
                      ],
                    ))
                : Container(child: Text("Loading..."))));
  }
}
