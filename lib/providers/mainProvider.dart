import 'package:flutter/material.dart';

class MainState with ChangeNotifier {
  MainState();

  String _query = '';
  String _language = '';
  String _level = '';

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
  
}