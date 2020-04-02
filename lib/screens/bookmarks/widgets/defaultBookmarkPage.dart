import 'package:app/screens/bookmarks/widgets/emptyBookmarksAlert.dart';
import 'package:flutter/material.dart';

class DefaultBookmarkPage extends StatelessWidget {
  _alertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EmptyBookmarksAlert();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Icon(
        Icons.bookmark,
        size: 120.0,
        color: Colors.grey[400],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _alertDialog(context),
        tooltip: 'Increment Counter',
        child: const Icon(
          Icons.info_outline,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
