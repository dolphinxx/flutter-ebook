import 'package:flutter/material.dart';

import 'package:bookstore/pages/home.dart';
import 'package:bookstore/pages/book_detail.dart';
import 'package:bookstore/pages/read.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Route<dynamic> _getRoute(RouteSettings settings) {
    // Routes, by convention, are split on slashes, like filesystem paths.
    final List<String> path = settings.name.split('/');
    // We only support paths that start with a slash, so bail if
    // the first component is not empty:
    if (path[0] != '')
      return null;
    if (path[1] == 'book' && path.length == 3 && path[2] != '') {
      final int bid = int.parse(path[2]);
      return new MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => new BookDetailPage(bid),
      );
    }
    if(path[1] == 'read' && path.length == 4) {
      final int bid = int.parse(path[2]);
      final int cid = int.parse(path[3]);
      return new MaterialPageRoute(
        settings: settings,
          builder: (BuildContext context) => new ReadPage(bid, cid)
      );
    }
    if(path.length == 1 && path[0] == '') {
      return new MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => new HomePage(),
      );
    }
    // The other paths we support are in the routes table.
    return null;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
//        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF1ABC9C),
        accentColor: Color(0xFFFF8040),
        textTheme: TextTheme(
          body1: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[500]
          ),
          body2: TextStyle(
            fontSize: 16.0,
            color: Colors.black
          )
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage()
      },
      onGenerateRoute: _getRoute
    );
  }
}
