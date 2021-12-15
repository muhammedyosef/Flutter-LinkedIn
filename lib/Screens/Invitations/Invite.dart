// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linked_in/Screens/Model/Userss.dart';
import 'package:linked_in/Screens/Model/noti.dart';

class Invite extends StatefulWidget {
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  List requst = [];
  bool data = true;
  getRequests() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("notifications")
          .get()
          .then((value) => value.docs.forEach((element) {
                Request model = Request.fromJson(element.data());
                if (model.sendTo == event?.uid) {
                  requst.add({"id": element.id, "data": model});
                  data = false;
                }
              }));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: data
          ? Center(
              child: Text("NO Requests"),
            )
          : ListView(
              children: [
                Card(
                  child: Container(
                    height: 100,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Expanded(
                              child: Image.network("${requst[0].img}"),
                              flex: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ListTile(
                                    title: Text(
                                        "${requst[0].firstname}  ${requst[0].lastname}"),
                                    // subtitle: Text("${requst[0].firstname}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        child: Text("Accept"),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('FriendList')
                                              .add({
                                            "sendFrom": requst[0].sendFrom,
                                            "sendTo": requst[0].sendTo,
                                            "dataTime": DateTime
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      TextButton(
                                        child: Text("Reject"),
                                        onPressed: () {
                                          print(requst[1]);
                                        },
                                      ),
                                      SizedBox(
                                        width: 8,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          flex: 8,
                        ),
                      ],
                    ),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.all(10),
                ),
              ],
            ),
    );
  }
}
