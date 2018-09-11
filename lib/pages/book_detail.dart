import 'package:flutter/material.dart';
import 'package:bookstore/data/repository.dart';
import 'package:bookstore/model/book_detail_dto.dart';
import 'package:bookstore/model/chapter_dto.dart';
import 'package:bookstore/widgets/panel.dart';

class BookDetailPage extends StatelessWidget {
  final int id;

  BookDetailPage(this.id);

  @override
  Widget build(BuildContext context) {
    Widget _buildDetail(BookDetailDTO data) {
      final double labelFontSize = 16.0;
      Widget topSection = Container(
        padding: EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 120.0,
              height: 120.0 * 4 / 3,
              padding: EdgeInsets.all(4.0),
              decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[500])),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: FractionalOffset.topCenter,
                      image: NetworkImage(
                        data.book.cover,
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 2.0),
                      child: Text(data.book.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              height: 0.8)),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2.0),
                      child: Text('作者：${data.book.author}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: labelFontSize,
                              color: Colors.grey[500])),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 2.0),
                        child: Text('分类：${data.book.category}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: labelFontSize,
                                color: Colors.grey[500]))),
                    Container(
                      margin: EdgeInsets.only(bottom: 2.0),
                      child: Text('状态：${data.book.serial}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: labelFontSize,
                              color: Colors.grey[500])),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2.0),
                      child: Text(
                          '更新：${data.book.updateTime}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: labelFontSize,
                              color: Colors.grey[500])),
                    ),
                    Row(
                      children: <Widget>[
                        Text('最新：',
                            style: TextStyle(
                                fontSize: labelFontSize,
                                color: Colors.grey[500])),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(data.book.newestChapter.name,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
      Widget btnSection = Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(right: 5.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: FlatButton(
                onPressed: () => Navigator.pushNamed(context, '/read/$id/${data.catalog[0].id}'),
                child: Text(
                  '开始阅读',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  '加入书架',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          )
        ],
      );
      Widget introSection = Panel(
        titleText: '${data.book.name}小说简介',
        body: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Text(
            data.book.introduction,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style:
            TextStyle(color: Colors.grey[500], fontSize: 16.0, height: 1.5),
          ),
        ),
        margin: EdgeInsets.only(top: 12.0),
      );
      List<Widget> newestChaptersItems = [];
      for(ChapterDTO chapter in data.newestChapters) {
        newestChaptersItems.add(Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]))
          ),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/read/$id/${chapter.id}'),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                chapter.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black
                ),
              ),
            ),
          ),
        ));
      }

      Widget newestChaptersSection = Panel(
        titleText: '${data.book.name}最新章节 更新时间：${data.book.updateTime}',
        body: Column(
          children: newestChaptersItems,
        ),
        margin: EdgeInsets.only(top: 12.0),
      );

      Widget chaptersSection = _ChaptersSection(data.book.id, data.catalog, data.page, data.size, data.totalPages);

      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        children: <Widget>[topSection, btnSection, introSection, newestChaptersSection, chaptersSection],
      );
    }
    Widget body = FutureBuilder<BookDetailDTO>(
      future: fetchBookDetail(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        if (!snapshot.hasData) {
          return ListView(children: [
            Container(
              height: MediaQuery.of(context).size.height / 2 + 100.0,
              child: Center(child: CircularProgressIndicator()),
            ),
          ]);
        }
        return _buildDetail(snapshot.data);
      },
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment.centerLeft,
          onPressed: () {
            Navigator.canPop(context)
                ? Navigator.pop(context)
                : Navigator.pushReplacementNamed(context, '/');
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
        title: Center(
          child: Text('未知小说网', style: TextStyle(color: Colors.white),),
        ),
        actions: <Widget>[
          IconButton(onPressed: () => {}, icon: Icon(Icons.search, color: Colors.white))
        ],
      ),
      body: body,
    );
  }
}

class _ChaptersSection extends StatefulWidget {
  final int bid;
  final List<ChapterDTO> data;
  final int page;
  final int size;
  final int totalPages;
  _ChaptersSection(this.bid, this.data, this.page, this.size, this.totalPages);
  @override
  State createState() {
    return new _ChaptersSectionState(bid, data, page, size, totalPages);
  }
}

class _ChaptersSectionState extends State<_ChaptersSection> {
  final int bid;
  List<ChapterDTO> data;
  int page;
  final int size;
  int totalPages;
  List<DropdownMenuItem<int>> options;

  _ChaptersSectionState(this.bid, this.data, this.page, this.size, this.totalPages) {
    options = [];
    for (int i = 0; i < totalPages; i++) {
      options.add(DropdownMenuItem<int>(
        value: i + 1,
        child: Text('第${i * size + 1}-${(i + 1) * size}章', overflow: TextOverflow.ellipsis,softWrap: true,),
      ));
    }
  }

  void goPage(int page) {
    setState(() {
      this.data = null;
    });
    fetchBookDetailChapterList(bid, page).then((value) {
      setState(() {
        this.page = page;
        this.data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(data == null) {
      return  Container(
        child: Panel(
          titleText: '全部章节列表',
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }
    List<Widget> chaptersItems = [];
    for(ChapterDTO chapter in data) {
      chaptersItems.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[200]))
        ),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/read/${chapter.bid}/${chapter.id}'),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              chapter.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
              ),
            ),
          ),
        ),
      ));
    }

    Widget chaptersSection = Panel(
      titleText: '全部章节列表',
      body: Column(
        children: chaptersItems,
      ),
      margin: EdgeInsets.only(top: 12.0),
    );
    Widget paginationSection = Container(
      margin: EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
      decoration: BoxDecoration(
      ),
      child: Row(
//        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: page == 1 ? Colors.grey[500] : Theme.of(context).primaryColor,
            ),
            child: FlatButton(
              onPressed: page == 1 ? null : () {goPage(page - 1);},
              child: Text(
                  '上一页',
                  style: TextStyle(
                      color: Colors.white
                  )
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[500])
              ),
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: page,
                    onChanged: (_page){goPage(_page);},
                    items: options,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: page == totalPages ? Colors.grey[500] : Theme.of(context).primaryColor,
            ),
            child: FlatButton(
                onPressed: page == totalPages ? null : () {goPage(page + 1);},
                child: Text(
                    '下一页',
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
            ),
          ),
        ],
      ),
    );
    return Container(
      child: Column(
        children: <Widget>[
          chaptersSection,
          paginationSection
        ],
      ),
    );
  }
}