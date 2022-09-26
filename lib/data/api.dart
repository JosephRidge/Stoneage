import 'dart:convert';

import 'package:http/http.dart' as http;

import 'globals.dart' as globals;

Future<Map<String,dynamic>> makeApiCall(path) async {
  final response = await http
      .get(Uri.parse(globals.BASE_URL_POSTMAN+path));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. json.decode
    return (jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}