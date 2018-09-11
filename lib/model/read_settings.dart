import 'package:dson/dson.dart';
part 'object_to_json.g.dart';
@serializable
class ReadSettings {
  static double fontSizeBig = 24.0;
  static double fontSizeMiddle = 20.0;
  static double fontSizeSmall = 16.0;
  static int defaultBackgroundColor = 0xFFE7F4FE;
  static int defaultTextColor = 0xFF000000;
  static double defaultLineHeight = 1.5;
  static double defaultParagraphHeight = 10.0;
  double fontSize;
  bool night;
  int backgroundColor;
  int textColor;
  double lineHeight;
  double paragraphHeight;

  ReadSettings(
      {this.fontSize,
      this.night,
      this.backgroundColor,
      this.textColor,
      this.lineHeight,
      this.paragraphHeight}) {
    this.fontSize = fontSize ?? fontSizeMiddle;
    this.night = night ?? false;
    this.backgroundColor = backgroundColor ?? defaultBackgroundColor;
    this.textColor = textColor ?? defaultTextColor;
    this.lineHeight = lineHeight ?? defaultLineHeight;
    this.paragraphHeight = paragraphHeight ?? defaultParagraphHeight;
  }
}
