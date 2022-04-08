import 'dart:convert';

import 'package:http/http.dart' as http;

class MyClient extends http.BaseClient {
  final _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    try {
      return _httpClient.send(request);
    } finally {
      _httpClient.close();
    }
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String> headers}) {
    try {
      return _httpClient
          .get(url, headers: headers)
          .timeout(Duration(seconds: 60));
    } finally {
      _httpClient.close();
    }
  }

@override
  Future<http.Response> post(Uri url, {body, Map<String, String> headers,Encoding encoding}) async {
    try {
      return _httpClient
          .post(url, body: body, headers: headers,encoding: encoding)
          .timeout(Duration(seconds: 60));
    } finally {
      _httpClient.close();
    }
  }
}
