import 'package:test/test.dart';
import 'package:bookstore/model/read_settings.dart';
import 'package:bookstore/utils/read_settings.dart';
import 'package:flutter/services.dart';
main() {
  test('initialize', () {
    ReadSettings readSettings = new ReadSettings();
    expect(readSettings.fontSize, ReadSettings.fontSizeMiddle);
  });
  test('read', () {});
  test('write', () async {
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{}; // set initial values here if desired
      }
      return null;
    });
    ReadSettings readSettings = new ReadSettings(fontSize: ReadSettings.fontSizeBig);
    await setReadSettings(readSettings);
    ReadSettings actual = await getReadSettings();
    expect(actual.fontSize, equals(ReadSettings.fontSizeBig));
  });
}