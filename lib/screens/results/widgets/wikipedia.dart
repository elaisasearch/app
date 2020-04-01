import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Wikipedia extends StatelessWidget {
  final String url;
  final String title;
  final String summary;

  Wikipedia({
    Key key,
    @required this.url,
    @required this.title,
    @required this.summary,
  }) : super(key: key);

  // method to open a url
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
                    'Wikipedia',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                          onTap: () {_launchUrl(url);},
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]),
                          ))),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Text(summary.substring(0, 200),
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 12))),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        highlightColor: Colors.transparent,
                        child: Text('LEARN MORE'),
                        onPressed: () { _launchUrl(url); },
                      )
                      
                      )
                ])));
  }
}
