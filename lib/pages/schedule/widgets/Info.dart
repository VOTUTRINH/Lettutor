import 'package:flutter/material.dart';
import 'package:individual_project/models/schedule/schedule.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:provider/provider.dart';

class Info extends StatelessWidget {
  Info({required this.tutor});
  Tutor tutor;
  @override
  Widget build(BuildContext context) {
    // TODO: pass data
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 6, right: 6),
              child: CircularImage(imageUrl: tutor.avatar!)),
          Padding(
              padding: EdgeInsets.only(left: 6, right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tutor.name!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Row(
                    children: [
                      Image.asset(
                        'icons/flags/png/vn.png',
                        package: 'country_icons',
                        width: 22,
                        height: 22,
                      ),
                      SizedBox(width: 5),
                      Text("Viet Nam")
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // Add your onTap action here
                      print('InkWell tapped');
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.message_outlined,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Direct Message',
                          style: TextStyle(fontSize: 14.0, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
