import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Help extends StatelessWidget {
  const Help({super.key});
 static String id = 'Help';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.asset('assets/pdf/بروفايل الموجه الذهبية.pdf')
    );
  }
}