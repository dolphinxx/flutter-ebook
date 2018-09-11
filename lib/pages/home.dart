import 'package:flutter/material.dart';
import 'package:bookstore/data/repository.dart';
import 'package:bookstore/widgets/section_widget.dart';
import 'package:bookstore/widgets/book_card_widget.dart';
import 'package:bookstore/widgets/book_triple_grid_widget.dart';
import 'package:bookstore/model/home_dto.dart';

class HomePage extends StatelessWidget {

  List<Widget> buildSections(HomeDTO data) {
    Widget siteRecommendsSection = SectionWidget(
        title: '本站推荐',
        child: BookTripleGridWidget(books: data.siteRecommends)
    );
    Widget popularRecommendsSection = SectionWidget(
      title: '热门推荐',
      child: BookCardWidget(books: data.popularRecommends)
    );
    return [siteRecommendsSection, popularRecommendsSection];
  }

  @override
  Widget build(BuildContext context) {
    Widget navWidget = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[500])
        )
      ),
      child: Row(
        key: Key('nav'),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(onPressed: () {Navigator.popAndPushNamed(context, '/');}, child: Text('首页')),
          FlatButton(onPressed: () {Navigator.popAndPushNamed(context, '/catagories');}, child: Text('分类')),
          FlatButton(onPressed: () {Navigator.popAndPushNamed(context, '/ranks');}, child: Text('排行')),
          FlatButton(onPressed: () {Navigator.popAndPushNamed(context, '/finished');}, child: Text('完本')),
        ],
      ),
    );
    Widget body = FutureBuilder<HomeDTO>(
      future: fetchHome(),
      builder: (context, snapshot) {
        if(snapshot.hasError) print(snapshot.error);
        if(!snapshot.hasData) {
          return ListView(
              children: [
                navWidget,
                 Container(
                   height: MediaQuery.of(context).size.height / 2 + 100.0,
                   child: Center(
                       child: CircularProgressIndicator()
                   ),
                 )
                 ,
              ]
          );
        }
        List<Widget> items = buildSections(snapshot.data);
        items.insert(0, navWidget);
        return ListView(children: items);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            IconButton(
              alignment: Alignment.centerLeft,
              onPressed: () => {},
              icon: Icon(Icons.account_box),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text('未知小说网'),
              ),
            ),
            IconButton(
                onPressed: () => {},
                icon: Icon(Icons.search)
            )
          ],
        ),
      ),
      body: body,
    );
  }
}