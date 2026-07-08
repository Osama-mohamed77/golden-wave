import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Help extends StatefulWidget {
  const Help({super.key});
  static String id = 'Help';

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffC9C9C9),
                MyColors.myYellow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Row(
          children: [
            Spacer(),
            Text('Help'),
             Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            'assets/pdf/golden_wave-min.pdf',
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
