import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final String titleText;
  final Widget title;
  final Widget body;
  final EdgeInsetsGeometry margin;

  Panel({this.title, this.body, this.margin, this.titleText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: this.margin,
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
          decoration: BoxDecoration(
              color: Colors.green[50],
              border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor))),
          child: Align(
            alignment: Alignment.centerLeft,
            child: title != null ? title : Text(
              titleText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body
      ],
    );
  }
}
