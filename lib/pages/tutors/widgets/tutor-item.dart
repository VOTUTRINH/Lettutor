import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/tutor/tutor-info.dart';
import 'package:individual_project/models/tutor/tutor.dart';
import 'package:individual_project/pages/tutors/tutor-detail.dart';
import 'package:individual_project/widgets/avatar.dart';
import 'package:individual_project/pages/tutors/widgets/star_rating.dart';
import 'package:individual_project/services/tutor.service.dart';
import 'package:provider/provider.dart';
import 'package:individual_project/models/feedback.dart';

class TutorItem extends StatefulWidget {
  const TutorItem(
      {super.key, required this.tutor, this.feedbacks, this.onFavoriteChange});

  final TutorInfo tutor;
  final List<FeedBack>? feedbacks;
  final Function? onFavoriteChange;

  @override
  _TutorItemState createState() => _TutorItemState();
}

class _TutorItemState extends State<TutorItem> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    TutorDetailPage(tutorId: widget.tutor.userId),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: CircularImage(
                        imageUrl: widget.tutor.avatar!,
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            setState(() async {
                              final isFavorite =
                                  await TutorService.addAndRemoveTutorFavorite(
                                      widget.tutor.userId,
                                      authProvider.getAccessToken());
                              setState(() {
                                widget.tutor.isFavoriteTutor = isFavorite;
                              });
                            });
                          });
                        },
                        child: Icon(
                          widget.tutor.isFavoriteTutor!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.tutor.isFavoriteTutor!
                              ? Colors.red
                              : Colors.blue,
                          size: 36.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(widget.tutor.name ?? '',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            child: Row(
                          children: [
                            //  Image.asset(
                            //     'icons/flags/png/${widget.tutor.user!.country!.toLowerCase()}.png',
                            //     package: 'country_icons',
                            //     width: 22,
                            //     height: 22,
                            //   )

                            SizedBox(width: 5),
                            Text(widget.tutor.country!)
                          ],
                        ))
                      ],
                    )),
                StarRating(size: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: widget.tutor.specialties!
                        .split(',')
                        .map((tag) => Container(
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.only(
                                  left: 12, right: 12, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 169, 201, 232)),
                              child: Text(
                                tag,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              ),
                            ))
                        .toList(), // Create a Tag widget for each tag
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 14, bottom: 14),
                  child: Wrap(
                    children: [Text(widget.tutor.bio ?? '')],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TutorDetailPage(
                            tutorId: widget.tutor.userId,
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.book_online,
                          color: Colors.blue,
                        ),
                        Text("Book", style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
