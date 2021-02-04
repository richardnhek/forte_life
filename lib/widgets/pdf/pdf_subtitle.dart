import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/widgets.dart';

class PDFSubtitle extends StatelessWidget {
  PDFSubtitle({this.title, this.font});

  final String title;
  final Font font;
  @override
  Widget build(Context context) {
    return Container(
        width: 80,
        child: Center(
            child: Text(title, style: TextStyle(fontSize: 8, font: font))));
  }
}
