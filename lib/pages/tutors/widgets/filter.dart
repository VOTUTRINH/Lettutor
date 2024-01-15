import 'dart:async';

import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/widgets/tag.dart';
import 'package:individual_project/global.state/tutor-filter.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class Input extends StatelessWidget {
  const Input(
      {this.placeholder,
      this.width = 150,
      this.onChanged,
      this.controller,
      this.debounce});

  final String? placeholder;
  final double? width;
  final Function? onChanged;
  final TextEditingController? controller;
  final Timer? debounce;

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

class Filter extends StatelessWidget {
  Filter(
      {Key? key,
      this.specialties,
      this.nameController,
      this.countryController,
      this.nationalityController,
      this.debounce})
      : super(key: key);

  List<dynamic>? specialties;
  final TextEditingController? nameController;
  final TextEditingController? countryController;
  final MultiSelectController<NationalityFilter>? nationalityController;
  late Timer? debounce;

  @override
  Widget build(BuildContext context) {
    final listNationalityOptions = [
      ValueItem(
          label: 'Foreign Tutor',
          value: NationalityFilter(key: 'isForeign', isSelected: true)),
      ValueItem(
          label: 'VietNamese Tutor',
          value: NationalityFilter(key: 'isVietnamese', isSelected: true)),
      ValueItem(
          label: 'Native English Tutor',
          value: NationalityFilter(key: 'isNative', isSelected: true)),
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
              child: Row(children: [
            Input(
              placeholder: "Enter tutor name",
              width: 150,
              controller: nameController!,
              onChanged: (value) {
                if (debounce?.isActive ?? false) debounce?.cancel();
                debounce = Timer(const Duration(milliseconds: 500), () {
                  tutorFilter.setName(value);
                });
              },
            ),
            SizedBox(width: 10),
            Container(
                width: 150,
                child: MultiSelectDropDown<NationalityFilter>(
                  showClearIcon: true,
                  controller: nationalityController!,
                  hint: 'Search tutor nationality',
                  hintStyle:
                      TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
                  dropdownHeight: 150,
                  onOptionSelected: (options) {
                    tutorFilter.addNationalityFilter(
                        options.map((e) => e.value).toList());
                  },
                  options: listNationalityOptions,
                  selectionType: SelectionType.multi,
                  chipConfig: const ChipConfig(
                      wrapType: WrapType.wrap,
                      labelColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 221, 218, 218),
                      labelStyle: TextStyle(overflow: TextOverflow.ellipsis)),
                  optionTextStyle: const TextStyle(
                      fontSize: 12, overflow: TextOverflow.ellipsis),
                  selectedOptionIcon: const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                  ),
                  selectedOptionTextColor: Colors.blue,
                  searchEnabled: true,
                  onOptionRemoved: (index, option) {
                    if (debounce?.isActive ?? false) debounce?.cancel();
                    debounce = Timer(const Duration(milliseconds: 500), () {
                      tutorFilter.removeNationalityFilter(option.value!.key);
                    });
                  },
                )),
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
            children: specialties!.map((tag) => Tag(value: tag)).toList(),
          ),
        ),
      ]),
    );
  }
}
