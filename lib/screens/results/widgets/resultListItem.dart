import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class ResultListItem extends StatefulWidget {
  final String url;
  //final Meta meta;
  final meta;
  final String title;
  final String level;
  //final LevelMeta levelMeta;
  final levelMeta;
  final double pagerank;

  ResultListItem({
    Key key,
    @required this.url,
    @required this.meta,
    @required this.title,
    @required this.level,
    @required this.levelMeta,
    @required this.pagerank,
  }) : super(key: key);

  @override
  _ResultListItemState createState() =>
      new _ResultListItemState(url, meta, title, level, levelMeta);
}

class _ResultListItemState extends State<ResultListItem> {
  final String url;
  //final Meta meta;
  final meta;
  final String title;
  final String level;
  //final LevelMeta levelMeta;
  final levelMeta;

  _ResultListItemState(
    this.url,
    this.meta,
    this.title,
    this.level,
    this.levelMeta,
  );

  var bookmarks;
  bool isMarked = false;

  static DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd.MM.yyyy').format(now);

  // get bookmarks from local storage file
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/bookmrks.json');
  }

  Future getBookmarks() async {
    try {
      final file = await _localFile;
      // Read the file

      var fileData = await file.readAsString();

      if (fileData == null || fileData == '') {
        bookmarks = {'de': [], 'en': [], 'es': []};
      } else {
        bookmarks = await json.decode(fileData);
      }

      return bookmarks;
    } catch (e) {
      // If encountering an error, return
      return {'de': [], 'en': [], 'es': []};
    }
  }

  Future<File> addToBookmarks() async {
    if (this.isMarked) {
      setState(() {
        this.isMarked = false;
      });
    } else {
      setState(() {
        this.isMarked = true;
      });

      var newBookmark = {
        'date': formattedDate,
        'website': url,
        'title': title,
        'desc': this.meta['desc'],
        'keywords': this.meta['keywords'],
        'level_meta': levelMeta,
        'level': level,
      };

      bookmarks['en'].add(newBookmark);
    }

    final file = await _localFile;
    // Write the file
    return file.writeAsString(json.encode(bookmarks));
  }

  @override
  void initState() {
    super.initState();
    getBookmarks().then((value) {
      setState(() {
        bookmarks = value;
      });

      bookmarks.forEach((key, value) {
        switch (key) {
          case 'de':
            for (var bm in bookmarks['de']) {
              if (bm['website'] == url) {
                setState(() {
                  this.isMarked = true;
                });
              }
            }
            break;
          case 'en':
            for (var bm in bookmarks['en']) {
              if (bm['website'] == url) {
                setState(() {
                  this.isMarked = true;
                });
              }
            }
            break;
          case 'es':
            for (var bm in bookmarks['es']) {
              if (bm['website'] == url) {
                setState(() {
                  this.isMarked = true;
                });
              }
            }
            break;
          default:
            setState(() {
              this.isMarked = false;
            });
        }
      });
    });
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                // align content left
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.url.substring(0, 30)}...',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green[600],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                          onTap: () {
                            _launchUrl(widget.url);
                          },
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ))),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Text(widget.meta['desc'],
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 12))),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: ExpansionTile(
                        trailing: Icon(
                          Icons.insert_chart,
                          color: Colors.grey[700],
                        ),
                        title: null,
                        leading: IconButton(
                          icon: Icon(
                            this.isMarked ? Icons.bookmark : Icons.bookmark_border,
                            color: Colors.grey[700],
                          ),
                          onPressed: () {
                            addToBookmarks();
                          },
                        ),
                        children: <Widget>[
                          Container(
                              padding: new EdgeInsets.all(10.0),
                              child: Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Language Level: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(widget.level)
                                  ],
                                ),
                                Container(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Language Level distribution: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Padding(
                                            padding: new EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: Text(
                                                "A1:\t\t ${widget.levelMeta['A1']}%,\nA2:\t\t${widget.levelMeta['A2']}%,\nB1:\t\t ${widget.levelMeta['B1']}%,\nB2:\t\t${widget.levelMeta['B2']}%,\nC1:\t\t ${widget.levelMeta['C1']}%,\nC2:\t\t${widget.levelMeta['C2']}%")),
                                        Row(
                                          children: <Widget>[
                                            Text('Word Length: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              // capitalize first letter of difficulty
                                              // Returns: Easy | Hard
                                              '${widget.levelMeta['difficulty'][0].toUpperCase()}${widget.levelMeta['difficulty'].substring(1)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: widget.levelMeta[
                                                              'difficulty'] ==
                                                          'easy'
                                                      ? Colors.green
                                                      : Colors.red),
                                            )
                                          ],
                                        ),
                                      ],
                                    ))
                              ]))
                        ],
                      ))
                ])));
  }
}
