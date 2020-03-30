class SearchAPIResponse {
  final result;

  SearchAPIResponse({this.result});

  factory SearchAPIResponse.fromJson(Map<String, dynamic> json) {
    return SearchAPIResponse(
      result: json['result']
    );
  }
}