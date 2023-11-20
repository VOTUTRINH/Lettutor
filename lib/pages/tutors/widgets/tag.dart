import 'package:flutter/material.dart';
import 'package:individual_project/services/respository/tutor-filter.dart';
import 'package:provider/provider.dart';

class Tag extends StatefulWidget {
  Tag({this.text = '', this.isSelected = false});
  final String text;
  late bool isSelected;

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    final TutorFilter tutorFilter = context.watch<TutorFilter>();

    return InkWell(
        onTap: () {
          if (!widget.isSelected) {
            setState(() {
              tutorFilter.setspecialties(widget.text);
            });
          }
        },
        child: Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (widget.isSelected ||
                      tutorFilter.getspecialties() == widget.text)
                  ? Color.fromARGB(255, 169, 201, 232)
                  : Color.fromARGB(255, 222, 218, 218)),
          child: Text(
            widget.text,
            style: TextStyle(
                color: (widget.isSelected ||
                        tutorFilter.getspecialties() == widget.text)
                    ? Colors.blue
                    : Color.fromARGB(99, 107, 97, 97),
                fontSize: 12),
          ),
        ));
  }
}
