import 'package:flutter/material.dart';
class NavBar extends StatelessWidget {
  final String title;
  final Widget center;
  final Widget left;
  final Widget right;
  final Widget body;
  NavBar({this.title, this.body, this.center, this.left, this.right});
  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,

          flexibleSpace: Row(
            children: <Widget>[
              left,
              Expanded(
                flex: 1,
                child: center != null ? center : Text(title, style: TextStyle(color: Colors.white),),
              ),
              right
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16.0),
        )
      ],
    );
  }
}