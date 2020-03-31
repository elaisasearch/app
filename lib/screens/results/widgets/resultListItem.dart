import 'package:flutter/material.dart';

class ResultListItem extends StatelessWidget {
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
                    '${url.substring(0, 30)}...',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green[600],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Text(meta['desc'],
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 12))),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: ExpansionTile(
                        trailing: Icon(Icons.insert_chart, color: Colors.grey[700],),
                        title: null,
                        leading: IconButton(
                          icon: Icon(Icons.bookmark_border, color: Colors.grey[700],),
                          onPressed: () {},
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
                                                color: levelMeta['difficulty'] == 'easy' ? Colors.green : Colors.red
                                              ),
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
