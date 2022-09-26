import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoneage/data/api.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<Map<String, dynamic>> futureUser;
  List users = [];

  @override
  void initState() {
    super.initState();
    futureUser = makeApiCall("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
        appBar: AppBar(
          title: const Text("Welcome Home ✨ "),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureBuilder(
                future: futureUser,
                builder: (context, snapshot) {
                  users.clear();
                  if (snapshot.hasData) {
                    Map<String, dynamic> map =
                        snapshot.data as Map<String, dynamic>;
                    var data = List<Map<String, dynamic>>.from(map['data']);
                    for (var i = 0; i < data.length; i++) {
                      users.add(data[i]);
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.verified_user,
                            color: Colors.greenAccent,
                          ),
                          title: Text(
                            users[index]['username'],
                            style: const TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          subtitle: Text(
                            (users[index]['email'] == null)? " no email":users[index]['email'],
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                          ),
                          trailing: Text(
                            'created on ${users[index]['createdDate']}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      margin: const EdgeInsets.only(top: 50.0),
                      child: const Center(child: CircularProgressIndicator()));
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      futureUser = makeApiCall("");
                    });
                  },
                  tooltip: 'Users',
                  child: const Icon(Icons.refresh_rounded),
                ),
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
            ]));
  }
}
