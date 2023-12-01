import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/tutor-detail.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:individual_project/pages/tutors/widgets/feedback.dart';
import 'package:individual_project/pages/tutors/widgets/star_rating.dart';
import 'package:individual_project/pages/tutors/widgets/tag.dart';
import 'package:individual_project/pages/tutors/widgets/upcoming-lesson.dart';
import 'package:individual_project/services/models/tutor.dart';
import 'package:individual_project/services/respository/tutor-repositiory.dart';
import 'package:provider/provider.dart';
import 'package:country_icons/country_icons.dart';

class TutorItem extends StatefulWidget {
  const TutorItem({
    super.key,
    required this.tutor,
  });

  final Tutor tutor;

  @override
  _TutorItemState createState() => _TutorItemState();
}

class _TutorItemState extends State<TutorItem> {
  @override
  Widget build(BuildContext context) {
    final TutorRepository tutorRepository =
        Provider.of<TutorRepository>(context);

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
                builder: (context) => TutorDetailPage(
                  tutor: widget.tutor,
                ),
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
                        imageUrl:
                            "https://cdn.tuoitre.vn/thumb_w/730/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756.jpg",
                      ),
                    ),
                    Positioned(
                      top: 10.0, // Adjust the top and right values as needed
                      right: 10.0,
                      child: InkWell(
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
                            Image.asset(
                              'icons/flags/png/${widget.tutor.country!.toLowerCase()}.png',
                              package: 'country_icons',
                              width: 22,
                              height: 22,
                            ),
                            SizedBox(width: 5),
                            Text(widget.tutor.country!)
                          ],
                        ))
                      ],
                    )),
                StarRating(
                  size: 20,
                  rating: widget.tutor.rating,
                  isTap: false,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: widget.tutor.specialties!
                        .split(',')
                        .map((tag) => Tag(text: tag, isSelected: true))
                        .toList(), // Create a Tag widget for each tag
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 14, bottom: 14),
                  child: Wrap(
                    children: [Text(widget.tutor.description ?? '')],
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
                            tutor: widget.tutor,
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
