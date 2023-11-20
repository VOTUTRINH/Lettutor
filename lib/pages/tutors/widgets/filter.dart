import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/tag.dart';
import 'package:individual_project/pages/tutors/widgets/upcoming-lesson.dart';
import 'package:individual_project/services/respository/tutor-filter.dart';
import 'package:provider/provider.dart';

class Input extends StatelessWidget {
  const Input(
      {this.placeholder, this.width = 150, this.onChanged, this.controller});

  final String? placeholder;
  final double? width;
  final Function? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: this.width,
      height: 40,
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.only(right: 11, left: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color.fromARGB(180, 217, 217, 217)),
      ),
      child: TextField(
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          hintText: this.placeholder,
          hintStyle: TextStyle(fontSize: 14),
        ),
        controller: controller,
        onChanged: onChanged as void Function(String)?,
      ),
    );
  }
}

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController countryController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final tags = [
      "ALL",
      "English for kids",
      "English for Business",
      "Conversational",
      "STARTERS",
      "MOVERS",
      "FLYERS",
      "PET",
      "IELTS"
    ];

    final tutorFilter = Provider.of<TutorFilter>(context);

    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 10),
      child: Column(children: [
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              "Find a Tutor",
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.w700),
            )),
        // SET UP DROPDOWN, CALENDAR,...
        Row(children: [
          Flexible(
              child: Wrap(children: [
            Input(
              placeholder: "Enter tutor name",
              width: 160,
              controller: nameController,
              onChanged: (value) {
                tutorFilter.setName(value);
              },
            ),
            Input(
                placeholder: "Select tutor country",
                width: 130,
                controller: countryController,
                onChanged: (value) {
                  tutorFilter.setCountry(value);
                })
          ]))
        ]),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.topLeft,
          child: Text(
            "Select available tutoring time:",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Row(children: [
          Flexible(
              child: Wrap(children: [
            //ToDO: CALENDAR ...
            Input(
              placeholder: "Select a day",
              width: 120,
            ),
            Input(
              placeholder: "Select time",
              width: 140,
            ),
          ]))
        ]),
        Container(
          alignment: Alignment.topLeft,
          child: Wrap(
            children: tags.map((tag) => Tag(text: tag)).toList(),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    super.dispose();
  }
}
