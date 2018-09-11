import 'package:bookstore/model/book_dto.dart';

class HomeDTO {
  final List<BookDTO> siteRecommends;
  final List<BookDTO> popularRecommends;

  HomeDTO({this.siteRecommends, this.popularRecommends});

//  factory HomeDTO.fromJson(Map<String, dynamic> json) {
//    return HomeDTO(
//        siteRecommends: parseBooks(json['site_recommends']),
//        popularRecommends: parseBooks(json['popular_recommends']));
//  }
}