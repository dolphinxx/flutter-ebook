class ChapterDTO {
  int bid;
  final int id;
  final String name;
  final String volume;

  ChapterDTO({this.bid, this.id, this.name, this.volume});

//  factory ChapterDTO.fromJson(Map<String, dynamic> json) {
//    if (json == null) {
//      return null;
//    }
//    return ChapterDTO(
//        bid: json['bid'] as int,
//        id: json['id'] as int,
//        name: json['name'] as String,
//        volume: json['volume'] as String);
//  }
}