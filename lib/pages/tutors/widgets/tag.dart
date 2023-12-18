import 'package:flutter/material.dart';
import 'package:individual_project/global.state/tutor-filter.dart';
import 'package:provider/provider.dart';

class Tag extends StatefulWidget {
  Tag({this.value});
  final dynamic value;

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    final TutorFilter tutorFilter = Provider.of<TutorFilter>(context);

    return InkWell(
        onTap: () {
          setState(() {
            tutorFilter.setspecialties(widget.value.key);
          });
        },
        child: Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: tutorFilter.getspecialties() == widget.value.key
                  ? Color.fromARGB(255, 169, 201, 232)
                  : Color.fromARGB(255, 222, 218, 218)),
          child: Text(
            widget.value.name != null ? widget.value.name : widget.value,
            style: TextStyle(
                color: tutorFilter.getspecialties() == widget.value.key
                    ? Colors.blue
                    : Color.fromARGB(99, 107, 97, 97),
                fontSize: 12),
          ),
        ));
  }
}
