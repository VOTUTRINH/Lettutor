import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:individual_project/pages/tutors/widgets/star_rating.dart';
import 'package:individual_project/services/models/feedback.dart';
import 'package:provider/provider.dart';

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
            CircularImage(
                imageUrl:
                    "https://sandbox.api.lettutor.com/avatar/cb9e7deb-3382-48db-b07c-90acf52f541cavatar1686550060378.jpg",
                size: 32),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(children: [
                  Text(feedback!.userId!, style: TextStyle(fontSize: 12)),
                  SizedBox(width: 8),
                  Text(feedback!.createdAt!, style: TextStyle(fontSize: 12))
                ]),
                SizedBox(height: 5),
                StarRating(rating: feedback!.rating),
                SizedBox(height: 5),
                Text(feedback!.content!,
                    style: TextStyle(
                        fontSize: 14)) // TODO: get user name from user id
              ],
            ),
          ],
        ));
  }
}
