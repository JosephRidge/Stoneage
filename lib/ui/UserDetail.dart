import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stoneage/data/globals.dart' as globals;
import 'package:http/http.dart' as http;


class UserDetail extends StatelessWidget {
  // const UserDetail(user, {Key? key}) : super(key: key);
  const UserDetail(
      {super.key,
      required this.username,
      required this.email,
      required this.password,
      required this.createdAt, });
  final String username;
  final String email;
  final String password;
  final String createdAt;

  // DELETE USER
  Future<Map<String,dynamic>> makeApiCall(username) async {
    String path ="delete_user/$username";
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http
        .delete(Uri.parse(globals.BASE_URL_POSTMAN+path),headers: headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. json.decode
      Fluttertoast.showToast(
          msg: 'You deleted ${username}"s account  🤯',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return (jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      Fluttertoast.showToast(
          msg: 'Oops something, went wrong. ${username}"s account survived 🕺! ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Details"),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 26.0),
              child: Text(
                "Hi 👋, I'm $username 😎 ",
                style: const TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8 - .0),
              child: Row(
                children: [
                  const Text(
                    "📧 Email :",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  Text(
                    "$email ",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  )
                ],
              )),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Row(
                children: [
                  const Text(
                    "🔑 Account passcode : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  Text(
                    "$password ",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Text(
                    "📅 Account Created On : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                  Text(
                    "$createdAt ",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  )
                ],
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      makeApiCall(username);
                    },
                    label: Text("Delete ${username}'s account ?")),
              ))
        ]));
  }
}
