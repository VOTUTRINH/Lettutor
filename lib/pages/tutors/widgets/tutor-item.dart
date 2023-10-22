import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:individual_project/pages/tutors/widgets/tag.dart';
import 'package:individual_project/pages/tutors/widgets/upcoming-lesson.dart';
import 'package:provider/provider.dart';
import 'package:country_icons/country_icons.dart';

class StarRating extends StatefulWidget {
  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              rating = index + 1;
            });
          },
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            size: 36.0,
            color: Colors.amber, // Star color
          ),
        );
      }),
    );
  }
}

class TutorItem extends StatelessWidget {
  const TutorItem({
    super.key,
    required this.userId,
    this.avatar,
    this.name,
    this.country,
    this.description,
  });

  final String userId;
  final String? avatar;
  final String? name;
  final String? country;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: InkWell(
          onTap: () {},
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
                          // Handle onTap event
                        },
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.blue,
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
                        Container(child: Text(this.name ?? '')),
                        Container(child: Text(this.country ?? ''))
                      ],
                    )),
                StarRating(),
                Container(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      "ALL",
                      "English for kids",
                      "English for Business",
                      "Conversational",
                      "STARTERS"
                    ]
                        .map((tag) => Tag(text: tag))
                        .toList(), // Create a Tag widget for each tag
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 14, bottom: 14),
                  child: Wrap(
                    children: [Text(this.description ?? '')],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {},
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
