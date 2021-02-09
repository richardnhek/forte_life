import 'package:forte_life/widgets/pdf/pdf_subtitle.dart';
import 'package:pdf/widgets.dart';

class PDFColumn extends StatelessWidget {
  PDFColumn(
      {this.header,
      this.font,
      this.fontSize,
      // this.headerIcon,
      this.subHeader,
      this.subHeader2});

  final String header;
  final Font font;
  final double fontSize;
  // final Icon headerIcon;
  final String subHeader;
  final String subHeader2;

  @override
  Widget build(Context context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(header, style: TextStyle(font: font, fontSize: fontSize)),
          // headerIcon,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(subHeader, style: TextStyle(font: font, fontSize: fontSize)),
            Text(subHeader2, style: TextStyle(font: font, fontSize: fontSize))
          ])
        ]);
  }
}
