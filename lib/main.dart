import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// state management
import 'package:app/providers/mainProvider.dart';

// import widgets
import 'package:app/screens/main/main-screen.dart';

void main() => runApp(ChangeNotifierProvider<MainState>(
    create: (_) => MainState(), child: ElaisaApp()));

class ElaisaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Elaisa Search",
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: MainScreen());
  }
}
