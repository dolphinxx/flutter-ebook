import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  SectionWidget({Key key, this.title, this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          side: BorderSide(color: Colors.grey[500])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey[500], width: 0.5))),
            padding: EdgeInsets.all(5.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: child,
          )
        ],
      ),
    );
  }
}