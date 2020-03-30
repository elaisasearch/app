import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import model
import 'package:app/models/searchModel.dart';

class ResultsScreen extends StatefulWidget {
  // declare a field that holds the search information
  final Search search;

  // in the contructor, require the search information
  ResultsScreen({Key key, @required this.search}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResultsScreenState(this);

  void _search() async {
    final response = await http.get(
        'https://api.elaisa.org/find?query=${search.query}&language=${search.language}&level=${search.level}&key=mY6qXTRUczbx3Fav');

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('failed. status code is ${response.statusCode}');
    }
  }

  void onLoad(BuildContext context) {_search();}

  @override
  Widget build(BuildContext contexrt) {
    return Center(
      child: RaisedButton(
        onPressed: () => _search(),
        textColor: Colors.black,
        child: Text('Search'),
      ) 

    );
  }
}

class _ResultsScreenState extends State<ResultsScreen> {
  ResultsScreen resultsScreen;
  _ResultsScreenState(this.resultsScreen);

  // build the screen after it is loading. This is handled by the State widget.
  // Source: https://stackoverflow.com/questions/49466556/flutter-run-method-on-widget-build-complete
  @override
  Widget build(BuildContext context) => resultsScreen.build(context);

  @override
  void initState() => resultsScreen.onLoad(context);
}
