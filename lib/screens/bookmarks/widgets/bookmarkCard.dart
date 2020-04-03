import 'package:app/handlers/bookmarksHandler.dart';
import 'package:app/screens/main/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookmarkCard extends StatefulWidget {
  final String website;
  final desc;
  final String title;
  final String level;
  final levelMeta;
  final date;

  BookmarkCard(
      {@required this.website,
      @required this.desc,
      @required this.title,
      @required this.level,
      @required this.levelMeta,
      @required this.date});

  @override
  _BookmarkCardState createState() => _BookmarkCardState(this.website,
      this.desc, this.title, this.level, this.levelMeta, this.date);
}

class _BookmarkCardState extends State<BookmarkCard> {
  final String website;
  final desc;
  final String title;
  final String level;
  final levelMeta;
  final date;

  _BookmarkCardState(this.website, this.desc, this.title, this.level,
      this.levelMeta, this.date);

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
            elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                // align content left
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[900],
                      ),
                    ),
                    subtitle: Text(date),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0, left: 15.0),
                      child: GestureDetector(
                          onTap: () {
                            _launchUrl(website);
                          },
                          child: Text(
                            desc,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: ExpansionTile(
                        trailing: Icon(
                          Icons.insert_chart,
                          color: Colors.grey[700],
                        ),
                        title: null,
                        leading: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.grey[700],
                          onPressed: () {
                            deleteFromBookmarks(website);
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
                                    Text(level)
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
                                                "A1:\t\t ${levelMeta['A1']}%,\nA2:\t\t${levelMeta['A2']}%,\nB1:\t\t ${levelMeta['B1']}%,\nB2:\t\t${levelMeta['B2']}%,\nC1:\t\t ${levelMeta['C1']}%,\nC2:\t\t${levelMeta['C2']}%")),
                                        Row(
                                          children: <Widget>[
                                            Text('Word Length: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              // capitalize first letter of difficulty
                                              // Returns: Easy | Hard
                                              '${levelMeta['difficulty'][0].toUpperCase()}${levelMeta['difficulty'].substring(1)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      levelMeta['difficulty'] ==
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
