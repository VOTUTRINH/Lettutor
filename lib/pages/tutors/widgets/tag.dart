import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tag extends StatelessWidget {
  const Tag({this.text = ''});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 222, 218, 218)),
        child: InkWell(
          onTap: () {},
          child: Text(
            this.text,
            style:
                TextStyle(color: Color.fromARGB(99, 107, 97, 97), fontSize: 12),
          ),
        ));
  }
}
