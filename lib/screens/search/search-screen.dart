import 'package:flutter/material.dart';

// import widgets
import 'package:app/screens/search/widgets/searchDropDown.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    // create search text field
    final searchTextField = TextFormField(
      keyboardType: TextInputType.text,
      //autofocus: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: 'Search for documents'
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          // use full width / height
          alignment: Alignment(0.0, 0.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              // Expanded expands its child to fill the available space.
              Expanded(
                flex: 1,
                child: Image(
                  image: AssetImage('assets/images/logo.png'), 
                  width: 200
                )
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(child: SearchDropDown(dropdownValues: ['English', 'Deutsch', 'Espanol'], placeholder: 'Result Language')),
                        Expanded(child: SearchDropDown(dropdownValues: ['All', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2'], placeholder: 'Language Level'))
                      ],
                    ),
                    searchTextField
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}
