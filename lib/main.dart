import 'package:flutter/material.dart';

// import widgets
import 'package:app/screens/main/main-screen.dart';

void main() => runApp(ElaisaApp());

class ElaisaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Elaisa Search", 
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MainScreen()
    );
  }
}