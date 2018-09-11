import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookstore/model/read_settings.dart';
import 'dart:async';
import 'dart:convert';

Future<ReadSettings> getReadSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String raw = prefs.getString('read_settings');
  ReadSettings result;
  if (raw != null) {
    Map<String, dynamic> map = json.decode(raw);
    double fontSize = map['fontSize'] as double ??ReadSettings.fontSizeMiddle;
    bool night = map['night'] as bool ?? false;
    int backgroundColor = map['backgroundColor'] as int ?? ReadSettings.defaultBackgroundColor;
    int textColor = map['textColor'] as int ?? ReadSettings.defaultTextColor;
    double lineHeight = map['lineHeight'] as double ?? ReadSettings.defaultLineHeight;
    double paragraphHeight = map['paragraphHeight'] as double ?? ReadSettings.defaultParagraphHeight;
    result = ReadSettings(
        fontSize: fontSize,
        night: night,
        backgroundColor: backgroundColor,
        textColor: textColor,
        lineHeight: lineHeight,
        paragraphHeight: paragraphHeight);
  } else {
    result = ReadSettings();
  }
  return result;
}

Future<void> setReadSettings(ReadSettings settings) async {
  print('=============');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('read_settings', json.encode(settings));
  print('=============');
  return;
}
