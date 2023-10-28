import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/video.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:individual_project/pages/tutors/widgets/feedback.dart';
import 'package:individual_project/pages/tutors/widgets/star_rating.dart';
import 'package:individual_project/pages/tutors/widgets/tag.dart';
import 'package:individual_project/pages/tutors/widgets/tutor-item.dart';
import 'package:individual_project/services/models/tutor.dart';
import 'package:individual_project/services/models/feedback.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content
class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({super.key});

  @override
  _TutorDetailPage createState() => _TutorDetailPage();
}

class _TutorDetailPage extends State<TutorDetailPage> {
  final Tutor tutor = Tutor(
      userId: "1",
      avatar:
          "https://cdn.tuoitre.vn/thumb_w/730/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756.jpg",
      name: "Vo Tu Trinh",
      description:
          "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
      specialties:
          "English for kids,English for Business,Conversational,STARTERS",
      education: "BA",
      experience: "I have more than 10 years of teaching english experience",
      languages: "English",
      interests:
          "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
      country: "VN",
      video:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      rating: 4);
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
              .map((tag) => Tag(text: tag))
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
    final imageCountry = 'icons/flags/png/${tutor.country!.toLowerCase()}.png';

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                margin: EdgeInsets.only(top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircularImage(
                          imageUrl: tutor.avatar!,
                          size: 110,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  tutor.name!,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                )),
                                StarRating(rating: tutor.rating!),
                                Row(
                                  children: [
                                    Image.asset(
                                      imageCountry,
                                      package: 'country_icons',
                                      width: 22,
                                      height: 22,
                                    ),
                                    SizedBox(width: 5),
                                    Text(tutor.country!)
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 50, 0),
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(tutor.description!)),
                    //TODO: favorite + reporting

                    VideoPlayerScreen(link: tutor.video),
                    Container(
                        margin: EdgeInsets.only(bottom: 20, top: 35),
                        child: Column(
                          children: [
                            title("Education"),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 7, left: 15),
                                child: Text(tutor.education!,
                                    style: TextStyle(fontSize: 15)))
                          ],
                        )),
                    title("Languages"),
                    rederListTag(tutor.languages!),
                    title("Specialties"),
                    rederListTag(tutor.specialties!),
                    Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            title("Interests"),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 7, left: 15),
                                child: Text(tutor.interests!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)))
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            title("Teaching experience"),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 7, left: 15),
                                child: Text(tutor.experience!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)))
                          ],
                        )),
                    Container(
                      alignment: Alignment.topLeft,
                      child: title("Other review"),
                    ),
                    FeedBackUI(feedback: feedBack)
                  ],
                ))));
  }
}
