class APIResponse {
  final Object result;

  APIResponse({this.result});

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      result: json['result']
    );
  }
}

class SearchResponse {
  final Object spellCheck;
  final Object wikipedia;
  final Object documents;

  SearchResponse({this.spellCheck, this.wikipedia, this.documents});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      spellCheck: json['spellcheck'],
      wikipedia: json['wikipedia'],
      documents: json['documents']
    );
  }
}

class SpellCheckResponse {
  final bool checked;
  final String corretQuery;

  SpellCheckResponse({this.checked, this.corretQuery});

  factory SpellCheckResponse.fromJson(Map<String, dynamic> json) {
    return SpellCheckResponse(
      checked: json['checked'],
      corretQuery: json['correctquery']
    );
  }
}

class WikipediaResponse {
  final String url;
  final String title;
  final String summary;

  WikipediaResponse({this.url, this.title, this.summary});

  factory WikipediaResponse.fromJson(Map<String, dynamic> json) {
    return WikipediaResponse(
      url: json['url'],
      title: json['title'],
      summary: json['summary']
    );
  }
}

class DocumentsResponse {
  final int length;
  final List items;

  DocumentsResponse({this.length, this.items});

  factory DocumentsResponse.fromJson(Map<String, dynamic> json) {
    return DocumentsResponse(
      length: json['length'],
      items: json['items']
    );
  }
}

class Meta {
  final String language;
  final String keywords;
  final String author;
  final String publisher;
  final String desc;
  final String date;

  Meta({this.language, this.keywords, this.author, this.publisher, this.desc, this.date});
}

class LevelMeta {
  final String difficulty;
  final String a1;
  final String a2;
  final String b1;
  final String b2;
  final String c1;
  final String c2;

  LevelMeta({this.difficulty, this.a1, this.a2, this.b1, this.b2, this.c1, this.c2});
}

class DocumentItemResponse {
  final String url;
  final Meta meta;
  final String title;
  final String level;
  final LevelMeta levelMeta;
  final double pagerank;

  DocumentItemResponse({this.url, this.meta, this.title, this.level, this.levelMeta, this.pagerank});

  factory DocumentItemResponse.fromJson(Map<String, dynamic> json) {
    return DocumentItemResponse(
      url: json['url'],
      meta: json['meta'],
      title: json['title'],
      level: json['level'],
      levelMeta: json['level_meta'],
      pagerank: json['pagerank']
    );
  }
}

