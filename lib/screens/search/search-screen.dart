import 'package:app/models/searchResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import models
import 'package:app/models/searchModel.dart';

// import widgets
import 'package:app/screens/search/widgets/searchDropDown.dart';
import 'package:app/screens/results/results-screen.dart';
import 'package:app/screens/results/widgets/resultListItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query;
  String _language = 'en';
  String _level = 'all';

  @override
  Widget build(BuildContext context) {
    // create search text field
    final searchTextField = TextFormField(
      keyboardType: TextInputType.text,
      //autofocus: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Search for documents'),
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        showSearch(context: context, delegate: DocumentSearch());
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                padding: EdgeInsets.only(right: 30, left: 30),
                // use full width / height
                alignment: Alignment(0.0, 0.0),
                color: Colors.white,
                child: Column(children: <Widget>[
                  // Expanded expands its child to fill the available space.
                  Expanded(
                      flex: 1,
                      child: Image(
                          image: AssetImage('assets/images/logo.png'),
                          width: 200)),
                  Expanded(
                      flex: 2,
                      child: Column(children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: SearchDropDown(dropdownValues: [
                              'English',
                              'Deutsch',
                              'Espanol'
                            ], placeholder: 'Result Language')),
                            Expanded(
                                child: SearchDropDown(dropdownValues: [
                              'All',
                              'A1',
                              'A2',
                              'B1',
                              'B2',
                              'C1',
                              'C2'
                            ], placeholder: 'Language Level'))
                          ],
                        ),
                        searchTextField
                      ]))
                ]))));
  }
}

class DocumentSearch extends SearchDelegate {
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
    } else {
      print('failed. status code is ${response.statusCode}');
    }
  }

  // when waiting for API response, show circular progress
  _buildBody() {
    print(waiting);
    if (waiting) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
      ));
    } else {
      // show list of results after API response is fetched
      return ListView(
        children: documents
            .map((doc) => ResultListItem(
                url: doc['url'],
                meta: doc['meta'],
                title: doc['title'],
                level: doc['level'],
                levelMeta: doc['level_meta'],
                pagerank: doc['pagerank']))
            .toList(),
      );
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // take control back to previous page
        this.close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _search(new Search(query, 'en', 'all'));
    // TODO: handle state change if _search is done async. Show CircularProgress while search is running.
    return ListView(
      children: documents
          .map((doc) => ResultListItem(
              url: doc['url'],
              meta: doc['meta'],
              title: doc['title'],
              level: doc['level'],
              levelMeta: doc['level_meta'],
              pagerank: doc['pagerank']))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
