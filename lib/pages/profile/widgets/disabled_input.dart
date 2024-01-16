import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisabledInput extends StatefulWidget {
  const DisabledInput(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.changeValue,
      required this.phone,
      required this.isActivated})
      : super(key: key);
  final Function(
      {DateTime? birthday,
      String phone,
      String country,
      String level,
      String email}) changeValue;
  final String phone;
  final bool isActivated;
  final String title;
  final String hintText;

  @override
  State<DisabledInput> createState() => _DisabledInputState();
}

class _DisabledInputState extends State<DisabledInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 7, left: 5),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 17),
            ),
          ),
          TextField(
            style: TextStyle(fontSize: 17, color: Colors.grey[900]),
            controller: _controller,
            enabled: !widget.isActivated,
            onChanged: (value) => widget.changeValue(phone: value),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.only(left: 15, right: 15),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              hintText: widget.hintText,
            ),
          )
        ],
      ),
    );
  }
}
