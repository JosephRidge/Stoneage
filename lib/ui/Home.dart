import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoneage/data/api.dart';
import 'package:stoneage/ui/UserDetail.dart';

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
    print("Started **************");
    setState(() {
      futureUser = makeApiCall("");
    });
    super.initState();
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
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                UserDetail(
                                  username: users[index]['username'],
                                  email: (users[index]['email'] == null)?"NOT DEFINED":users[index]['email'],
                                  password: users[index]['password'],
                                  createdAt: users[index]['createdDate'],
                                ),));

                          },
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
              // This trailing comma makes auto-formatting nicer for build methods.
            ]));
  }
}
