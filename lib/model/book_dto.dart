import 'package:bookstore/model/chapter_dto.dart';

class BookDTO {
  final int id;
  final String name;
  final String author;
  final String cover;
  final String introduction;
  final int visits;
  final ChapterDTO newestChapter;
  final String category;
  final String serial;
  final String updateTime;
  final int chapterCount;

  BookDTO(
      {this.id,
        this.name,
        this.author,
        this.cover,
        this.introduction,
        this.visits,
        this.newestChapter,
        this.category,
        this.serial,
        this.updateTime,
        this.chapterCount});

//  factory BookDTO.fromJson(Map<String, dynamic> json) {
//    return BookDTO(
//        id: json['id'] as int,
//        name: json['name'] as String,
//        author: json['author'] as String,
//        cover: json['cover'] as String,
//        introduction: json['introduction'] as String,
//        visits: json['visits'] as int,
//        newestChapter: ChapterDTO.fromJson(json['newestChapter']),
//        category: json['category'] as String,
//        serial: json['serial'] as String,
//        updateTime: json['updateTime'] == null ? null : DateTime.fromMicrosecondsSinceEpoch((json['updateTime'] as int) * 1000),
//        chapterCount: json['chapterCount'] as int);
//  }
}