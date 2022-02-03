class ResponseModel {
  QueryData? query;
  Map<String, dynamic>? data;

  ResponseModel.fromJson(Map<dynamic, dynamic> json) {
    query = json['query'] != null ? QueryData.fromJson(json['query']) : null;
    data = json['data'];
  }
}

class QueryData {
  int? timestamp;
  String? baseCurrency;

  QueryData.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    baseCurrency = json['base_currency'];
  }
}