class SearchAPIResponse {
  final result;

  SearchAPIResponse({this.result});

  factory SearchAPIResponse.fromJson(Map<String, dynamic> json) {
    return SearchAPIResponse(
      result: json['result']
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
  final int a1;
  final int a2;
  final int b1;
  final int b2;
  final int c1;
  final int c2;
  final int unknown;

  LevelMeta({this.difficulty, this.a1, this.a2, this.b1, this.b2, this.c1, this.c2, this.unknown});
}