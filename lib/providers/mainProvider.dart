import 'package:flutter/material.dart';

class MainState with ChangeNotifier {
  MainState();

  String _query = '';
  String _language = '';
  String _level = '';

  // user state
  bool _loggedIn = false;
  String _email = '';
  String _firstname = '';
  String _lastname = '';

  void setQuery(String q) {
    _query = q;
    notifyListeners();
  }

  String get getQuery => _query;

  void setLanguage(String l) {
    _language = l;
    notifyListeners();
  }

  String get getLanguage => _language;

  void setLevel(String lvl) {
    _level = lvl;
    notifyListeners();
  }

  String get getLevel => _level;

  void signInUser(bool li, String e, String fn, String ln) {
    _loggedIn = li;
    _email = e;
    _firstname = fn;
    _lastname = ln;
  }

  void signOutUser() {
    _loggedIn = false;
    _email = '';
    _firstname = '';
    _lastname = '';
  }

  bool get getLoggedIn => _loggedIn;
  String get getEmail => _email;
  String get getFirstname => _firstname;
  String get getLastname => _lastname;
}
