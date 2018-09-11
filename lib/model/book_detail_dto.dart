import 'package:bookstore/model/book_dto.dart';
import 'package:bookstore/model/chapter_dto.dart';

class BookDetailDTO {
  final BookDTO book;

  final List<ChapterDTO> catalog;
  final List<ChapterDTO> newestChapters;
  final int page;
  final int size;
  final int totalPages;

  BookDetailDTO(
      {this.book, this.catalog, this.newestChapters, this.page, this.size, this.totalPages});

//  factory BookDetailDTO.fromJson(Map<String, dynamic> json) {
//    return BookDetailDTO(
//        book: BookDTO.fromJson(json['book']),
//        catalog: parseChapterList(json['catalog']),
//        newestChapters: parseChapterList(json['newestChapters']),
//        page: json['page'] as int,
//        size: json['size'] as int);
//  }
}