import 'package:flutter/material.dart';
import 'package:individual_project/widgets/avatar.dart';
import 'package:individual_project/pages/tutors/widgets/star_rating.dart';
import 'package:individual_project/models/feedback.dart';

class FeedBackUI extends StatelessWidget {
  FeedBackUI({this.feedback});

  final FeedBack? feedback;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Row(
          children: [
            CircularImage(imageUrl: feedback!.firstInfo.avatar!, size: 32),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(children: [
                  Text(feedback!.firstInfo.name,
                      style: TextStyle(fontSize: 12)),
                  SizedBox(width: 8),
                  Text(feedback!.createdAt, style: TextStyle(fontSize: 12))
                ]),
                SizedBox(height: 5),
                StarRating(rating: (feedback!.rating.ceil() * 1.0)),
                SizedBox(height: 5),
                Text(feedback!.content, style: TextStyle(fontSize: 14))
              ],
            ),
          ],
        ));
  }
}
