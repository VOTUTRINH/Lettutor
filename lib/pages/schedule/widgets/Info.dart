import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/avatar.dart';
import 'package:provider/provider.dart';

class Info extends StatelessWidget {
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
              child: CircularImage(
                  imageUrl:
                      "https://sandbox.api.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1684484879187.jpg")),
          Padding(
              padding: EdgeInsets.only(left: 6, right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Keegan",
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
