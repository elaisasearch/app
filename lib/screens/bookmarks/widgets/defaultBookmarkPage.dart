import 'package:flutter/material.dart';

class DefaultBookmarkPage extends StatelessWidget {
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
        onPressed: () => showDialog(
            context: context,
            child: Card(
                margin: MediaQuery.of(context).viewInsets +
                    const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 300.0),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          size: 40,
                        ),
                        title: Text(
                          'Store Bookmarks',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(top: 15),
                        child: Text(
                          'Search for documents and store any result to the bookmarks. It will appear on this screen afterward.',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.bottomRight,
                              child: FlatButton(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: Navigator.of(context).pop,
                              )))
                    ],
                  ),
                ))),
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
