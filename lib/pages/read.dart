import 'package:flutter/material.dart';
import 'package:bookstore/data/repository.dart';
import 'package:bookstore/model/chapter_detail_dto.dart';
import 'package:bookstore/widgets/primary_btn.dart';
import 'package:bookstore/utils/read_settings.dart';
import 'package:bookstore/model/read_settings.dart';

class ReadPage extends StatefulWidget {
  final int bid;
  final int cid;
  ReadPage(this.bid, this.cid);
  @override
  State createState() => ReadPageState(bid, cid);
}

class ReadPageState extends State<ReadPage> {

  final int bid;
  final int cid;
  ChapterDetailDTO data;
  ReadSettings readSettings = ReadSettings();

  ReadPageState(this.bid, this.cid) {
    fetchChapterDetail(bid, cid).then((value) => setState(() => this.data = value));
    getReadSettings().then((value) => setState(() => this.readSettings = value));
  }

  Widget createAppBar(String title, BuildContext context) {
    return AppBar(
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
        child: Text(title, style: TextStyle(color: Colors.white),),
      ),
      actions: <Widget>[
        IconButton(onPressed: () => {}, icon: Icon(Icons.search, color: Colors.white))
      ],
    );
  }

  Widget createContentBody(BuildContext context) {
    EdgeInsetsGeometry toolBtnPadding = EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0);
    EdgeInsetsGeometry toolBtnMargin = EdgeInsets.only(right: 8.0);
    List<Widget> listBody = [];
    Widget toolSection = DefaultTextStyle(
      style: TextStyle(
          fontSize: 14.0
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[500]))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  PrimaryBtn(
                    content: Text('字体'),
                    onPressed: () {},
                    padding: toolBtnPadding,
                    margin: toolBtnMargin,
                  ), PrimaryBtn(
                    content: Text('大'),
                    onPressed: () {
                      setReadSettings(readSettings).then((_) {
                        setState(() {
                          readSettings.fontSize = ReadSettings.fontSizeBig;
                        });
                      });
                    },
                    padding: toolBtnPadding,
                    margin: toolBtnMargin,
                    active: readSettings.fontSize == ReadSettings.fontSizeBig,
                  ), PrimaryBtn(
                    content: Text('中'),
                    onPressed: () {
                      setReadSettings(readSettings).then((_) {
                        setState(() {
                          readSettings.fontSize = ReadSettings.fontSizeMiddle;
                        });
                      });
                    },
                    padding: toolBtnPadding,
                    margin: toolBtnMargin,
                    active: readSettings.fontSize == ReadSettings.fontSizeMiddle,
                  ), PrimaryBtn(
                    content: Text('小'),
                    onPressed: () {
                        print('-----------------------------');
                      setReadSettings(readSettings).then((_) {
                        print('-----------------------------');
                        setState(() {
                          readSettings.fontSize = ReadSettings.fontSizeSmall;
                        });
                      });
                    },
                    padding: toolBtnPadding,
                    active: readSettings.fontSize == ReadSettings.fontSizeSmall,
                  )
                ],
              ),
            ),
            PrimaryBtn(
              onPressed: (){
                setReadSettings(readSettings).then((_) {
                  setState(() {
                    readSettings.night = !readSettings.night;
                  });
                });
              },
              content: Text(readSettings.night ?'开灯':'关灯'),
              padding: toolBtnPadding,
              active: readSettings.night,
            )
          ],
        ),
      ),
    );
    listBody.add(toolSection);
    Widget topPaginationSection = Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {},
                  child: Text('上一页', style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {},
                  child: Text('目录', style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {},
                  child: Text('下一页', style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {},
                  child: Text('进书架', style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
        ],
      ),
    );
    listBody.add(topPaginationSection);
    Widget contentSection = DefaultTextStyle(
        style: TextStyle(
            color: Color(readSettings.textColor),
            fontSize: readSettings.fontSize,
            height: readSettings.lineHeight
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
              children: data.content.map((line) {
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: readSettings.paragraphHeight),
                  child: Text(
                    line,
                    softWrap: true,
                  ),
                );
              }).toList()
          ),
        )
    );
    listBody.add(contentSection);

    Widget bottomPaginationSection = Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {},
                  child: Text('上一页', style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {},
                  child: Text('目录', style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {},
                  child: Text('下一页', style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: FlatButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {},
                  child: Text('存书签', style: TextStyle(color: Colors.white),)
              ),
            ),
          ),
        ],
      ),
    );
    listBody.add(bottomPaginationSection);

    return Scaffold(
      backgroundColor: Color(readSettings.backgroundColor),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
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
              child: Text(data.name, style: TextStyle(color: Colors.white),),
            ),
            actions: <Widget>[
              IconButton(onPressed: () => {}, icon: Icon(Icons.search, color: Colors.white))
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(listBody),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(data == null) {
      return Scaffold(
        appBar: createAppBar('', context),
        body: ListView(children: [
          Container(
            height: MediaQuery.of(context).size.height / 2 + 100.0,
            child: Center(child: CircularProgressIndicator()),
          ),
        ]),
      );
    }
    return createContentBody(context);
  }
}