import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

// Create a Form widget.
class NewsListPage extends StatefulWidget {
  @override
  NewsListPageState createState() {
    return NewsListPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class NewsListPageState extends State<NewsListPage> {

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container (
      child: new Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(15),
              child: Text('News', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
          ),
          Expanded(
            child: NewsListTab(),
          )
        ],
      ),
    );
  }
}

class NewsListTab extends StatefulWidget {
  static const title = 'News';
  static const androidIcon = Icon(Icons.library_books);
  static const iosIcon = Icon(CupertinoIcons.news);

  @override
  _NewsListTabState createState() => _NewsListTabState();
}

class _NewsListTabState extends State<NewsListTab> {
  static const _itemsLength = 7;

  List<Color> colors;
  List<String> titles;
  List<String> contents;

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  @override
  void initState() {
    colors = [Colors.black12, Colors.grey, Colors.black12, Colors.grey, Colors.black12, Colors.grey, Colors.black12, Colors.grey];
    titles = ['Title1', 'Title2', 'Title1', 'Title2', 'Title1', 'Title2', 'Title1', 'Title2'];
    contents = [truncateWithEllipsis(30, 'Content sdfsdfs sdfsdfs sdsfs sdfsfsdfs dssssssssssss sdfsdfsdf sdfsdfsdfs sdfs  sdfsdfsdfs sdfsdfsdfs sfsfds'), 'Content2', 'Content1', 'Content2', 'Content1', 'Content2', 'Content1', 'Content2'];
    super.initState();
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return null;

    return SafeArea(
      top: false,
      bottom: false,
      child: Card(
        elevation: 1.5,
        margin: EdgeInsets.fromLTRB(6, 12, 6, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: InkWell(
          // Make it splash on Android. It would happen automatically if this
          // was a real card but this is just a demo. Skip the splash on iOS.
          onTap: defaultTargetPlatform == TargetPlatform.iOS ? null : () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colors[index],
                  child: Text(
                    titles[index].substring(0, 1),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        contents[index],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // Non-shared code below because this tab uses different scaffolds.
  // ===========================================================================

  Widget _buildAndroid(BuildContext context) {
    return ListView.builder(
      itemBuilder: _listBuilder,
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: ListView.builder(
        itemBuilder: _listBuilder,
      ),
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}