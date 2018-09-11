import 'package:flutter/material.dart';
import 'package:bookstore/model/book_dto.dart';


class BookCardWidget extends StatelessWidget {
  BookCardWidget({Key key, this.books}):super(key:key);
  final List<BookDTO> books;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    double width = 55.0;
    double height = width * 4/3;
    for(BookDTO book in books) {
      children.add(Container(
        child: Row(
          children: <Widget>[
            Container(
              width: width,
              height: height,
              child: GestureDetector(
                onTap: () {Navigator.pushNamed(context, '/book/${book.id}');},
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(book.cover), fit: BoxFit.cover)
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 12.0),
                height: height,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            book.name,
                            style: TextStyle(fontSize: 16.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${book.visits}人阅读',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                          '作者：${book.author}',
                          style: TextStyle(
                              color: Colors.grey[500]
                          )
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                          book.introduction,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[500]
                          )
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ));
      children.add(Divider(
        color: Colors.grey[500],
      ));
    }
    return Column(
      children: children,
    );
  }
}