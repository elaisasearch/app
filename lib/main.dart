import 'package:flutter/material.dart';

// import widgets
import 'package:app/widgets/appBottomBar/appBottomBar.dart';

void main() => runApp(ElaisaApp());

class ElaisaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Elaisa Search", 
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: AppBottomBar()
    );
  }
}