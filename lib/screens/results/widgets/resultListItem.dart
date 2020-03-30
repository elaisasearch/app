import 'package:flutter/material.dart';

// import models
import 'package:app/models/searchResponseModel.dart';

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
      child: 
      ListTile(
        title: Text(title),
        subtitle: Text(url)
      )
    );
  }
}