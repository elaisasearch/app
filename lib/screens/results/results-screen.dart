import 'dart:convert';
import 'package:app/screens/results/widgets/resultListItem.dart';
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

  // in the contructor, require the search information
  ResultsScreen({Key key, @required this.search}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState(search);
}

class _ResultsScreenState extends State<ResultsScreen> {
  Search search;

  // state
  SearchAPIResponse searchAPIResponse;
  bool waiting = true;

  // documents list
  List documents = [];

  _search(Search search) async {
    final response = await http.get(
        'https://api.elaisa.org/find?query=${search.query}&language=${search.language}&level=${search.level}&key=mY6qXTRUczbx3Fav');

    if (response.statusCode == 200) {
      // parse Elaisa API result to objects
      searchAPIResponse =
          SearchAPIResponse.fromJson(json.decode(response.body));
      documents = searchAPIResponse.result['documents']['items'];

      setState(() {
        waiting = false;
      });
    } else {
      print('failed. status code is ${response.statusCode}');
    }
  }

  // call search function after contructor is loaded
  _ResultsScreenState(Search search) : super() {
    _search(search);
  }

  // when waiting for API response, show circular progress
  _buildBody() {
    if (waiting) {
      return Center(
        child: 
          CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor:  AlwaysStoppedAnimation<Color>(Colors.black12),
        )
      );
    } else {
      // show list of results after API response is fetched
      return ListView(
        children: documents
            .map((doc) => ResultListItem(url: doc['url'], meta: doc['meta'], title: doc['title'], level: doc['level'], levelMeta: doc['level_meta'], pagerank: doc['pagerank']))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext contexrt) {
    return Center(
        child: Scaffold(
            backgroundColor: Colors.white,
            drawer: MainDrawer(),
            appBar: MainAppBar(),
            body: _buildBody()));
  }
}
