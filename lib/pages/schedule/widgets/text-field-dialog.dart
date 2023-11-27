import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldDialog extends StatelessWidget {
  TextEditingController _textController = TextEditingController();
  TextFieldDialog({Key? key, this.link}) : super(key: key);

  String? link;
  _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Special Request',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          content: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(top: 24, bottom: 24),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text("*Note",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))),
                TextField(
                  controller: _textController,
                  maxLines: 5, // Set to null for multiple lines
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: "Wish topic",
                      hintStyle: TextStyle(color: Color.fromARGB(77, 16, 6, 6)),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(new Radius.circular(2.0))),
                      labelStyle: TextStyle(
                          color: const Color.fromARGB(255, 74, 68, 68))),
                )
              ],
            ),
          )),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Access the entered text using _textController.text
                print('Entered text: ${_textController.text}');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showPopup(context);
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Text(this.link ?? "", style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}
