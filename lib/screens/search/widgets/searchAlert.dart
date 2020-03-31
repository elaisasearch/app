import 'package:flutter/material.dart';

class SearchAlert extends StatelessWidget {

  final String title;
  final String content;

  SearchAlert({
    Key key,
    @required this.title,
    @required this.content,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
        title: ListTile(
          leading: Icon(Icons.error),
          title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
        ),
        content: Text(content),
        actions: <Widget>[
          FlatButton(child: Text('OK', style: TextStyle(color: Colors.black87, fontSize: 20)), onPressed: () { Navigator.of(context).pop();},)
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
      );
  }
}