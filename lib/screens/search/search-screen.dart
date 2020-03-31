import 'package:app/models/searchResponseModel.dart';
import 'package:app/models/wordsResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:english_words/english_words.dart' as words;

// import models
import 'package:app/models/searchModel.dart';

// import widgets
import 'package:app/screens/search/widgets/searchDropDown.dart';
import 'package:app/screens/results/widgets/resultListItem.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  String _language = 'en';
  String _level = 'all';

  final List<String> kWords;

  _SearchScreenState()
      // initialize english word suggestions in a sorted list
      : kWords = List.from(Set.from(words.all))
          ..sort((w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase())),
        super();

  @override
  Widget build(BuildContext context) {
    // create search text field
    final searchTextField = TextField(
        controller: TextEditingController(text: _query),
        keyboardType: TextInputType.text,
        //autofocus: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Search for documents'),
        textInputAction: TextInputAction.search,
        onTap: () async {
          // open the search delegate screen on tap
          // store the search delegate text field value to the _query variable when the user closes the search delegate
          _query = await showSearch(
              context: context,
              delegate: DocumentSearchDelegate(kWords),
              query: _query);
        });

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

class DocumentSearchDelegate extends SearchDelegate<String> {
  Search search;

  // state
  SearchAPIResponse searchAPIResponse;
  bool waiting = true;

  // documents list
  List documents = [];

  final List<String> _words;
  final List<String> _history;

  DocumentSearchDelegate(List<String> words)
      : _words = words,
        _history = <String>['summer', 'football'],
        super();

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

  // set the hint text in the delegate search field
  @override
  String get searchFieldLabel => 'Search for documents';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.mic),
              tooltip: 'Voice input',
              onPressed: () {
                this.query = 'TBW: Get input from voice';
              },
            ),
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
        this.close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: _search(new Search(query, 'en', 'all')),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          // check if snapshot has state waiting or is done
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]),
            ));
          }
          return ListView(
            // for every item in the found documents list, render the list item
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _WordSuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }
}

class _WordSuggestionList extends StatelessWidget {
  const _WordSuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(Icons.search),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
