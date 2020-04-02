import 'package:app/handlers/bookmarksHandler.dart';
import 'package:app/screens/bookmarks/widgets/bookmarkCard.dart';
import 'package:flutter/material.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({
    Key key,
  }) : super(key: key);

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  _buildBookmarks(bookmarks) {
    List<BookmarkCard> bookmarkCards = [];

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

      return ListView(children: bookmarkCards);
    } catch (error) {
      return Center(
          child: Icon(
        Icons.bookmark,
        size: 120.0,
        color: Colors.grey[400],
      ));
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
