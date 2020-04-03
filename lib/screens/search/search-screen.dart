import 'package:app/models/searchResponseModel.dart';
import 'package:app/providers/mainProvider.dart';
import 'package:app/screens/search/widgets/searchAlert.dart';
import 'package:app/screens/search/widgets/wordSuggestionsList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:english_words/english_words.dart' as words;

// state management
import 'package:provider/provider.dart';

// import models
import 'package:app/models/searchModel.dart';
import 'package:app/models/wikipediaModel.dart';
import 'package:app/models/wordsResponseModel.dart';
import 'package:app/models/searchResponseModel.dart';

// import widgets
import 'package:app/screens/search/widgets/searchDropDown.dart';
import 'package:app/screens/results/widgets/resultListItem.dart';
import 'package:app/screens/results/widgets/wikipedia.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> kWords;

  _SearchScreenState()
      // initialize english word suggestions in a sorted list
      : kWords = List.from(Set.from(words.all))
          ..sort((w1, w2) => w1.toLowerCase().compareTo(w2.toLowerCase())),
        super();

  @override
  Widget build(BuildContext context) {
    // state
    final MainState mainState = Provider.of(context);

    String _query = mainState.getQuery;

    // create search text field
    final searchTextField = Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Material(
          color: Colors.white,
            elevation: 5.0,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: TextField(
                controller: TextEditingController(text: _query),
                keyboardType: TextInputType.text,
                autofocus: false,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                    border: InputBorder.none,
                    hintText: 'Search for documents',
                    suffixIcon: Material(
                      elevation: 2.0,                
                      color: Colors.white, child: Icon(Icons.search),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                
                textInputAction: TextInputAction.search,
                onChanged: (_) {
                  showSearch(
                      context: context,
                      delegate: DocumentSearchDelegate(kWords),
                      query: _query);
                },
                onTap: () async {
                  // open the search delegate screen on tap
                  // store the search delegate text field value to the _query variable when the user closes the search delegate
                  _query = await showSearch(
                      context: context,
                      delegate: DocumentSearchDelegate(kWords),
                      query: _query);

                  // store _query to state
                  mainState.setQuery(_query);
                })));

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
                                child: SearchDropDown(
                              dropdownValues: <String>['en', 'de', 'es'],
                              dropdownItems: <String>[
                                'English',
                                'Deutsch',
                                'Espanol'
                              ],
                              placeholder: 'Result Language',
                              type: 'language',
                            )),
                            Expanded(
                                child: SearchDropDown(
                              dropdownValues: <String>[
                                'all',
                                'A1',
                                'A2',
                                'B1',
                                'B2',
                                'C1',
                                'C2'
                              ],
                              dropdownItems: <String>[
                                'All',
                                'A1',
                                'A2',
                                'B1',
                                'B2',
                                'C1',
                                'C2'
                              ],
                              placeholder: 'Language Level',
                              type: 'level',
                            ))
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
  Wiki wikipedia;

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
      wikipedia = new Wiki(
          url: searchAPIResponse.result['wikipedia']['url'],
          title: searchAPIResponse.result['wikipedia']['title'],
          summary: searchAPIResponse.result['wikipedia']['summary']);
    } else {
      print('failed. status code is ${response.statusCode}');
    }
  }

  Widget _buildResults() {
    if (documents.length > 0) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            // TODO: Make this scrollable
            children: <Widget>[
              // show wikipedia entry card if wikipedia information is provided
              wikipedia.url != null
                  ? Wikipedia(
                      url: wikipedia.url,
                      title: wikipedia.title,
                      summary: wikipedia.summary)
                  : null,
              Expanded(
                  child: ListView(
                scrollDirection: Axis.vertical,
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
              ))
            ],
          ));
    } else {
      return Center(
          child: Icon(
        Icons.search,
        size: 120.0,
        color: Colors.grey[400],
      ));
    }
  }

  // set the hint text in the delegate search field
  @override
  String get searchFieldLabel => 'Search for documents';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(
          Icons.clear,
          color: Colors.black87,
        ),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        color: Colors.black87,
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
    // state
    final MainState mainState = Provider.of(context);

    // return alert if language or level aren't defined
    if (mainState.getLanguage == '') {
      return SearchAlert(
        title: 'Result Language is missing',
        content: 'Please define a result language for your search.',
      );
    } else if (mainState.getLevel == '') {
      return SearchAlert(
        title: 'Language Level is missing',
        content: 'Please define a language level for your search.',
      );
    }

    return FutureBuilder(
        future: _search(
            new Search(query, mainState.getLanguage, mainState.getLevel)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // check if snapshot has state waiting or is done
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]),
                )));
          }
          return _buildResults();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return WordSuggestionList(
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
