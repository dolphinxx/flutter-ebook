import "package:test/test.dart";
import 'package:bookstore/data/site_parser.dart';
import 'package:bookstore/model/chapter_detail_dto.dart';
import 'dart:io';
import 'dart:convert';

main() {
  test('parse_chapter_detail_test', () async {
    Uri uri = Platform.script;
    var file = File(uri.resolve('test/site_parser/parse_chapter_detail_test.html').toFilePath());
    String raw = await file.readAsString(encoding: utf8);
    ChapterDetailDTO actual = parseChapterDetail(raw);
    expect(actual.name, equals('第210章 一定是他！'));
    expect(actual.content, hasLength(53));
    expect(actual.content[0], equals('只是，他可以选择不信，但他不敢去赌……眼下纠结与惊恐中，还没等他有所决断，王宝乐这里精神抖擞，仰天大笑，非但没有后退，甚至主动向着黑衣中年蓦然而来，目中露出寒芒杀机，口中传出震动天地，让八方轰鸣，天雷狂暴的大吼！'));
    expect(actual.content.last, equals('“我在这里，我在这里！！”他惊喜中就要撕下赵雅梦的衣服，可陡然间觉得不对，于是把赵雅梦抱的紧了点，然后松开抱着的卓一凡，顺手撕裂他的衣服，向着天空挥舞……'));
  });
}