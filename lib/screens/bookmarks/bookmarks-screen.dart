import 'package:app/handlers/bookmarksHandler.dart';
import 'package:app/screens/bookmarks/widgets/bookmarkCard.dart';
import 'package:app/screens/bookmarks/widgets/defaultBookmarkPage.dart';
import 'package:flutter/material.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({
    Key key,
  }) : super(key: key);

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  _buildBookmarks(bookmarks) {
    List<BookmarkCard> bookmarkCards = [];

    if (bookmarks['en'].length != 0) {
      try {
        bookmarks['en'].forEach((bookmark) {
          bookmarkCards.add(BookmarkCard(
            website: bookmark['website'],
            desc: bookmark['desc'],
            level: bookmark['level'],
            levelMeta: bookmark['level_meta'],
            title: bookmark['title'],
            date: bookmark['date'],
          ));
        });

        //return ListView(children: bookmarkCards);
        return AnimatedList(
            key: _listKey,
            initialItemCount: bookmarks['en'].length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return FadeTransition(
                  opacity: animation,
                  child: BookmarkCard(
                      website: bookmarks['en'][index]['website'],
                      desc: bookmarks['en'][index]['desc'],
                      level: bookmarks['en'][index]['level'],
                      levelMeta: bookmarks['en'][index]['level_meta'],
                      title: bookmarks['en'][index]['title'],
                      date: bookmarks['en'][index]['date']));
            });
      } catch (error) {
        return Center(
            child: Icon(
          Icons.bookmark,
          size: 120.0,
          color: Colors.grey[400],
        ));
      }
    } else {
      return DefaultBookmarkPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: getBookmarks(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // check if snapshot has state waiting or is done
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]),
                ));
              }
              return _buildBookmarks(snapshot.data);
            }));
  }
}
