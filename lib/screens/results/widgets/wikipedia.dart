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
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black87, width: 0.2))),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
        //shape:
        //    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                      color: Colors.grey[800],
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
                                color: Colors.black87),
                          ))),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Text(summary.substring(0, 200),
                          style: TextStyle(
                              color: Colors.black87, fontSize: 12))),
                  Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: GestureDetector(
                        child: Text('LEARN MORE', style: TextStyle(fontWeight: FontWeight.w500),),
                        onTap: () { _launchUrl(url); },
                      )
                      
                      )
                ])));
  }
}
