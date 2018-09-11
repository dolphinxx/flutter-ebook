import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:bookstore/model/book_dto.dart';
import 'package:bookstore/model/chapter_dto.dart';
import 'package:bookstore/model/home_dto.dart';
import 'package:bookstore/model/book_detail_dto.dart';
import 'package:bookstore/model/chapter_detail_dto.dart';

HomeDTO parseHome(String raw) {
  Document document = parse(raw);
  List<BookDTO> siteRecommends = document.querySelectorAll('#tj>ul>li').map((el) {
    String cover = el.querySelector('img').attributes['src'];
    String href = el.querySelector('>a').attributes['href'];
    int id = getBidFromUrl(href);
    String name = el.querySelector('>span>a').text;
    return BookDTO(id: id, name: name, cover: cover);
  }).toList();
  List<BookDTO> popularRecommends = document.querySelectorAll('#rmtj>ul').map((el) {
    String cover = el.querySelector('>.tjimg>img').attributes['src'];
    List<Element> spanList = el.querySelectorAll('.tjxs>span');
    String name = spanList[0].text;
    String href = spanList[0].children[0].attributes['href'];
    int id = getBidFromUrl(href);
    String author = spanList[1].text.substring(3);
    String introduction = spanList[2].text;
    int visits = int.parse(spanList[3].querySelector('i').text);
    return BookDTO(id: id, name: name, cover: cover, author: author, introduction: introduction, visits: visits);
  }).toList();
  List<BookDTO> recentUpdates = [];
  List<Element> recentElList = document.querySelectorAll('#zjgx>ul>li');
  recentElList.removeWhere((el) {return el.classes.contains('xbk');});
  for(int i = 0;i < recentElList.length;i++) {
    Element el1 = recentElList[i];
    Element el2 = recentElList[i++ + 1];
    String name = el1.children[0].nodes[1].text;
    String href = el1.children[0].nodes[1].attributes['href'];
    int id = getBidFromUrl(href);
    String author = el1.children[0].nodes[2].text.substring(3);
    String updateTime = el1.children[1].children[0].text;
    String introduction = el2.text.substring(2);
    recentUpdates.add(BookDTO(id: id, name: name, author: author, introduction: introduction, updateTime: updateTime));
  }
  return HomeDTO(siteRecommends: siteRecommends, popularRecommends: popularRecommends);
//  return HomeDTO.fromJson(json.decode(raw));
}

BookDetailDTO parseBookDetail(String raw) {
  Document html = parse(raw);
  String cover = html.querySelector('.block_img2>img').attributes['src'];
  Element infoBlock = html.querySelector('.block_txt2');
  String name = infoBlock.querySelector('>h2>a').text;
  String href = infoBlock.querySelector('>h2>a').attributes['href'];
  int id = getBidFromUrl(href);
  List<Element> pList = infoBlock.querySelectorAll('>p');
  String author = pList[2].text.substring(3);
  String category = pList[3].querySelector('a').text;
  String serial = pList[4].text.substring(3);
  String updateTime = pList[5].text.substring(3);
  Element newestChapterEl = pList[6].querySelector('a');
  String newestChapterLink = newestChapterEl.attributes['href'];
  int newestChapterId = int.parse(newestChapterLink.substring(0, newestChapterLink.lastIndexOf('.')).substring(newestChapterLink.lastIndexOf('/') + 1));
  String newestChapterName = newestChapterEl.text;
  String introduction = html.querySelector('.intro_info').nodes.where((el) => el.nodeType == Node.TEXT_NODE && el.text != '最新章节推荐地址：').join('\n');
  List<ChapterDTO> newestChapters = parseChapterList(html.querySelectorAll('.chapter')[0].querySelectorAll('a'));
  List<ChapterDTO> chapters = parseChapterList(html.querySelectorAll('.chapter')[1].querySelectorAll('a'));
  String pageHref = html.querySelector('[name=pageselect]').children.last.attributes['value'];
  int totalPages = int.parse(pageHref.substring(pageHref.lastIndexOf('_') + 1, pageHref.lastIndexOf('.')));
  return BookDetailDTO(
      book: BookDTO(id: id, name: name, cover: cover, author: author, serial: serial, category: category, updateTime: updateTime, introduction: introduction, newestChapter: ChapterDTO(bid: id, name: newestChapterName, id: newestChapterId)),
      newestChapters: newestChapters,
      catalog: chapters,
      page: 1,
      size: 20,
      totalPages: totalPages
  );
//  return BookDetailDTO.fromJson(json.decode(raw));
}

List<ChapterDTO> parseChapterList(List<Element> list) {
  return list.map((el) {
    String chapterName = el.text;
    String href = el.attributes['href'];
    int chapterId = int.parse(href.substring(href.lastIndexOf('/') + 1, href.lastIndexOf('.')));
    return ChapterDTO(id: chapterId, name: chapterName);
  }).toList();
}

List<ChapterDTO> parseBookDetailChapterList(String raw) {
  Document html = parse(raw);
  return parseChapterList(html.querySelectorAll('.chapter')[1].querySelectorAll('a'));
}

ChapterDetailDTO parseChapterDetail(String raw) {
  Document document = parse(raw);
//  String title = document.head.querySelector('title').text;
//  List<String> titleTuple = title.split('_');
//  String name = titleTuple[0];
//  String bookName = titleTuple[1];
//  String category = titleTuple[2];
  String name = document.querySelector('#header>.zhong').text;
  List<String> lines = document.getElementById('nr').nodes.where((node) {return node.nodeType == Node.TEXT_NODE;}).map((node) {return node.text.trim();}).where((line) {return line != '';}).toList();
  List<Element> buttons = document.querySelector('.nr_page').children;
  String prevHref = buttons[0].attributes['href'];
  String nextHref = buttons[2].attributes['href'];
  return ChapterDetailDTO(name: name, content: lines, prevId: getCidFromUrl(prevHref), nextId: getCidFromUrl(nextHref));
}

int getCidFromUrl(String url) {
  if(!url.endsWith('.html')) {
    return -1;
  }
  return int.parse(url.substring(url.lastIndexOf('/') + 1, url.lastIndexOf('.')));
}

int getBidFromUrl(String url) {
  url = url.substring(0, url.length - 1);
  return int.parse(url.substring(url.lastIndexOf('/') + 1));
}