import 'package:bookstore/data/repository.dart';
import "package:test/test.dart";
import 'package:bookstore/model/book_detail_dto.dart';
import 'package:bookstore/model/home_dto.dart';
main() {
  test('fetchHome', () async {
   HomeDTO actual = await fetchHome();
   expect(actual.siteRecommends, hasLength(3));
  });

  test('fetchBookDetail', () async {
    BookDetailDTO actual = await fetchBookDetail(45096);
//    expect(actual.book.name, equals('网游之神级土豪'));
  });
}