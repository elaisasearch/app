import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:convert';

var bookmarks;

DateTime now = DateTime.now();
String formattedDate = DateFormat('dd.MM.yyyy').format(now);

// get bookmarks from local storage file
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  // print(directory.path);
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/bokmrks.json');
}

Future getBookmarks() async {
  try {
    final file = await _localFile;
    // Read the file

    var fileData = await file.readAsString();

    if (fileData == null || fileData == '') {
      bookmarks = {'de': [], 'en': [], 'es': []};
    } else {
      bookmarks = await json.decode(fileData);
    }

    return bookmarks;
  } catch (e) {
    // If encountering an error, return
    return {'de': [], 'en': [], 'es': []};
  }
}

Future<File> addToBookmarks(url, title, meta, levelMeta, level) async {
  var newBookmark = {
    'date': formattedDate,
    'website': url,
    'title': title,
    'desc': meta['desc'],
    'keywords': meta['keywords'],
    'level_meta': levelMeta,
    'level': level,
  };

  try {
    bookmarks['en'].add(newBookmark);
  } catch (error) {
    bookmarks = {'en': [], 'de': [], 'es': []};
    bookmarks['en'].add(newBookmark);
  }

  final file = await _localFile;
  // Write the file
  return file.writeAsString(json.encode(bookmarks));
}

Future deleteFromBookmarks(website) async {
  var _bookmarks = await getBookmarks();

  _bookmarks.forEach((lang, bmList) {
    //print(bmList.length);
    for (var bm in bmList.toSet()) {
      if (bm['website'] == website) {
        bmList.remove(bm);
      }
    }
  });

  var _file = await _localFile;
  _file.writeAsString(json.encode(_bookmarks));
}
