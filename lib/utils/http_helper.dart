import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> get(String url, {Map<String, String> h}) async {
  final headers = h ?? await _headers();
  var response = await http.get(url, headers: headers);
  return response;
}

Future<http.Response> post(String url, {body, Encoding encoding, Map<String, String> header}) async {
  final headers = header ?? await _headers();
  var response =
      await http.post(url, body: body, headers: headers, encoding: encoding);
  return response;
}

Future<http.Response> put(String url, {body}) async {
  final headers = await _headers();
  var response = await http.put(url, body: body, headers: headers);
  return response;
}

Future<http.Response> patch(String url, {body, Encoding encoding}) async {
  final headers = await _headers();
  var response =
      await http.patch(url, body: body, headers: headers, encoding: encoding);
  return response;
}

Future<http.Response> delete(String url) async {
  final headers = await _headers();
  var response = await http.delete(url, headers: headers);
  return response;
}

Future<Map<String, String>> _headers() async {

  Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  return headers;
}
