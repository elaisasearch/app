class WordIndexAPIResponse {
  final result;

  WordIndexAPIResponse({this.result});

  factory WordIndexAPIResponse.fromJson(Map<String, dynamic> json) {
    return WordIndexAPIResponse(result: json['result']);
  }
}
