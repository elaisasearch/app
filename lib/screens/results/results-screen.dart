import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import model
import 'package:app/models/searchModel.dart';
import 'package:app/models/searchResponseModel.dart';

// import widgets
import 'package:app/screens/main/widgets/mainAppBar.dart';
import 'package:app/screens/main/widgets/mainDrawer.dart';

class ResultsScreen extends StatefulWidget {
  // declare a field that holds the search information
  final Search search;

  // state
  SearchResponse searchResponse;
  APIResponse apiResponse;
  DocumentsResponse documentsResponse;
  DocumentItemResponse documentItemResponse;

  // in the contructor, require the search information
  ResultsScreen({Key key, @required this.search}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResultsScreenState(this);

  void _search() async {
    final response = await http.get(
        'https://api.elaisa.org/find?query=${search.query}&language=${search.language}&level=${search.level}&key=mY6qXTRUczbx3Fav');

    if (response.statusCode == 200) {

      // parse Elaisa API result to objects
      apiResponse = APIResponse.fromJson(json.decode(response.body));
      searchResponse = SearchResponse.fromJson(json.decode(apiResponse.result));

      print(documentsResponse.length);


    } else {
      print('failed. status code is ${response.statusCode}');
    }
  }

  void onLoad(BuildContext context) {_search();}

  @override
  Widget build(BuildContext contexrt) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: MainDrawer(),
        appBar: MainAppBar(),
        body: ListView(
          children: <Widget>[
            Card(child: ListTile(title: Text(search.query),),)
          ],
        ),
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
