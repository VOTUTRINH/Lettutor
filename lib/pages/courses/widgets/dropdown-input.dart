import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropdownInput extends StatefulWidget {
  @override
  _DropdownInputState createState() => _DropdownInputState();

  final List<String> options;
  final String hintText;

  DropdownInput({required this.options, required this.hintText});
}

class _DropdownInputState extends State<DropdownInput> {
  // Define a list of items that you want to show in the men

  // Define a variable that holds the currently selected item from the menu
  String? selectedLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownSearch<String>(
        items: widget.options,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16)),
        ),
        onChanged: print,
      ),
    );
  }
}
