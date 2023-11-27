import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/calendar_booking.dart';
import 'package:individual_project/pages/tutors/widgets/video.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:individual_project/pages/tutors/widgets/feedback.dart';
import 'package:individual_project/pages/tutors/widgets/star_rating.dart';
import 'package:individual_project/pages/tutors/widgets/tag.dart';
import 'package:individual_project/pages/tutors/widgets/tutor-item.dart';
import 'package:individual_project/services/models/tutor.dart';
import 'package:individual_project/services/models/feedback.dart';
import 'package:individual_project/services/respository/feedback-repository.dart';
import 'package:individual_project/services/respository/tutor-repositiory.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content
class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({super.key, required this.tutor});
  final Tutor tutor;
  @override
  _TutorDetailPage createState() => _TutorDetailPage();
}

class _TutorDetailPage extends State<TutorDetailPage> {
  final FeedBack feedBack = FeedBack(
      id: "1",
      userId: "Vo Tu Trinh",
      tutorId: "",
      rating: 4,
      content: "Adadaa",
      createdAt: "2 hours ago");
  rederListTag(String tags) {
    if (tags != null) {
      List<String> listTag = tags.split(",");
      return Container(
        margin: EdgeInsets.only(top: 10, left: 10, bottom: 20),
        alignment: Alignment.topLeft,
        child: Wrap(
          children: listTag
              .map((tag) => Tag(
                    text: tag,
                    isSelected: true,
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

  //TODO
  renderListFeedback() {}

  @override
  Widget build(BuildContext context) {
    final imageCountry =
        'icons/flags/png/${widget.tutor.country!.toLowerCase()}.png';
    final tutorRepository = Provider.of<TutorRepository>(context);
    final feedbackRepository = Provider.of<FeedbackRepository>(context);
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircularImage(
                          imageUrl: widget.tutor.avatar!,
                          size: 110,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  widget.tutor.name!,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                )),
                                StarRating(rating: widget.tutor.rating!),
                                Row(
                                  children: [
                                    Image.asset(
                                      imageCountry,
                                      package: 'country_icons',
                                      width: 22,
                                      height: 22,
                                    ),
                                    SizedBox(width: 5),
                                    Text(widget.tutor.country!)
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                    //TODO: favorite + reporting
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.tutor.isFavorite = !widget.tutor.isFavorite!;
                            tutorRepository.update(widget.tutor);
                          });
                        },
                        child: Icon(
                          widget.tutor.isFavorite!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.tutor.isFavorite!
                              ? Colors.red
                              : Colors.blue,
                          size: 36.0,
                        ),
                      )
                    ]),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 50, 0),
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(widget.tutor.description ?? "")),

                    VideoPlayerScreen(link: widget.tutor.video),
                    Container(
                        margin: EdgeInsets.only(bottom: 20, top: 35),
                        child: Column(
                          children: [
                            title("Education"),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 7, left: 15),
                                child: Text(widget.tutor.education!,
                                    style: TextStyle(fontSize: 15)))
                          ],
                        )),
                    title("Languages"),
                    rederListTag(widget.tutor.languages!),
                    title("Specialties"),
                    rederListTag(widget.tutor.specialties!),

                    ...[
                      {
                        "title": "Interests",
                        "content": widget.tutor.interests!
                      },
                      {
                        "title": "Teaching experience",
                        "content": widget.tutor.experience
                      }
                    ]
                        .map((e) => Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Column(
                              children: [
                                title(e['title'] as String),
                                Container(
                                    alignment: Alignment.topLeft,
                                    margin:
                                        EdgeInsets.only(bottom: 7, left: 15),
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
                    ...feedbackRepository
                        .getFeedbacksByTutorId(widget.tutor.userId)
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
                                      CalendarBooking(tutor: widget.tutor),
                                ),
                              );
                            },
                            child: Text("List booking",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)))) // List
                  ],
                ))));
  }
}
