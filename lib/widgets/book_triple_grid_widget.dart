import 'package:flutter/material.dart';
import 'package:bookstore/model/book_dto.dart';


class BookTripleGridWidget extends StatelessWidget {
  BookTripleGridWidget({Key key, this.books}) : super(key: key);
  final List<BookDTO> books;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < books.length; i++) {
      EdgeInsets insets;
      if (i % 3 == 0) {
        insets = EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 5.0);
      } else if (i % 3 == 2) {
        insets = EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0);
      } else {
        insets = EdgeInsets.all(5.0);
      }
      children.add(
        Expanded(
            flex: 1,
            child: Container(
                padding: insets,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: GestureDetector(
                        onTap: () {Navigator.pushNamed(context, '/book/${books[i].id}');},
                        child: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  alignment: FractionalOffset.topCenter,
                                  image: NetworkImage(
                                    books[i].cover,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Center(child: Text(books[i].name))
                  ],
                ))),
      );
    }
    return Row(
      key: key,
      children: children,
    );
  }
}