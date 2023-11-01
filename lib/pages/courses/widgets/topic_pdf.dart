import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class TopicPdfViewer extends StatefulWidget {
  const TopicPdfViewer({Key? key, required this.url, required this.title})
      : super(key: key);

  final String url;
  final String title;

  @override
  _TopicPdfViewerState createState() => _TopicPdfViewerState();
}

class _TopicPdfViewerState extends State<TopicPdfViewer> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    _downloadPDF();
  }

  Future<void> _downloadPDF() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(
        '${dir.path}/myPDF.pdf'); // Replace 'myPDF.pdf' with a suitable file name.

    final response = await http.get(Uri.parse(widget.url));
    await file.writeAsBytes(response.bodyBytes);

    if (mounted) {
      setState(() {
        localFilePath = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 20,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
      ),
      body: Center(
        child: localFilePath != null
            ? PDFView(
                filePath: localFilePath!,
                onPageChanged: (page, total) {
                  // Handle page change if needed
                  print('Page changed to $page of $total');
                },
              )
            : CircularProgressIndicator(), // Show a loading indicator while downloading the PDF.
      ),
    );
  }
}
