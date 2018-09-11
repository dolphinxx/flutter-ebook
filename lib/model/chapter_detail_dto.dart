class ChapterDetailDTO {
  final String bookName;
  final String name;
  final List<String> content;
  final int prevId;
  final int nextId;
  ChapterDetailDTO({this.bookName, this.name, this.content, this.prevId, this.nextId});
}