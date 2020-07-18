import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

final String _baseUrl = "https://api.chucknorris.io/";

Future<dynamic> getData() async {
  return await http.get(_baseUrl);
}

Future<dynamic> getData2() async {
  var responseJson;
  try {
    final response = await http.get(_baseUrl);
    responseJson = _response(response);
  } on SocketException {
    throw Exception('No Internet connection');
  }
  return responseJson;
}

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw Exception(response.body.toString());
    case 401:

    case 403:
      throw Exception(response.body.toString());
    case 500:

    default:
      throw Exception(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}