
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:bookstore/data/site_parser.dart';
import 'package:bookstore/model/home_dto.dart';
import 'package:bookstore/model/book_detail_dto.dart';
import 'package:bookstore/model/chapter_dto.dart';
import 'package:bookstore/model/chapter_detail_dto.dart';
import 'dart:convert';

//final String gateway = 'http://10.0.2.2:3000';
//final String gateway = 'http://192.168.10.112:3000';

Future<HomeDTO> fetchHome() async {
  final response = await http.Client().get('https://m.biquke.com');
  return compute(parseHome, utf8.decode(response.bodyBytes));
//return parseHome(utf8.decode(response.bodyBytes));
}

Future<BookDetailDTO> fetchBookDetail(int id) async {
  final response = await http.Client().get('https://m.biquke.com/bq/${(id/1000).floor()}/$id');
  return compute(parseBookDetail, utf8.decode(response.bodyBytes)).then((result) {
    result.catalog.forEach((item) => item.bid = id);
    result.newestChapters.forEach((item) => item.bid = id);
    return result;
  });
//return parseBookDetail(utf8.decode(response.bodyBytes));
}

Future<List<ChapterDTO>> fetchBookDetailChapterList(int id, int page) async {
  final response = await http.Client().get('https://m.biquke.com/bq/${(id/1000).floor()}/$id/index_$page.html');
  return compute(parseBookDetailChapterList, utf8.decode(response.bodyBytes)).then((list) {
    list.forEach((item) => item.bid = id);
    return list;
  });
}

Future<ChapterDetailDTO> fetchChapterDetail(int bid, int cid) async {
  final response = await http.Client().get('https://m.biquke.com/bq/${(bid~/1000)}/$bid/$cid.html');
  return compute(parseChapterDetail, utf8.decode(response.bodyBytes));
}