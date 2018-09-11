import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final String text;
  final Widget content;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback onPressed;
  final bool active;

  PrimaryBtn({this.text, this.content, this.padding, this.margin, this.onPressed, this.active=false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: active ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        padding: padding ?? ButtonTheme.of(context).padding,
        margin: margin,
        child: content ??
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
      ),
    );
  }
}
