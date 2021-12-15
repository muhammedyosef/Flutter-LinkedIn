import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linked_in/Screens/Model/Userss.dart';
import 'package:linked_in/Screens/Model/noti.dart';

class Connections extends StatefulWidget {
  @override
  _ConnectionsState createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
  bool data = true;
  List user = [];
  var obj;
  var obj1;
  getFriend() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("FriendList")
          .get()
          // ignore: avoid_function_literals_in_foreach_calls
          .then((value) => value.docs.forEach((element) async {
                Request model = Request.fromJson(element.data());
                if (model.sendTo == event?.uid) {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(model.sendFrom)
                      .get()
                      .then((value) => obj = value.data());
                  Welcome model1 = Welcome.fromJson(obj);
                  user.add(model1);
                  data = false;
                  setState(() {});
                } else if (model.sendFrom == event?.uid) {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(model.sendTo)
                      .get()
                      .then((value) => obj1 = value.data());
                  Welcome model1 = Welcome.fromJson(obj1);
                  user.add(model1);
                  data = false;
                  setState(() {});
                }
              }));
    });
    print(user);
  }

  @override
  void initState() {
    super.initState();
    getFriend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Connections",
        ),
      ),
      body: data
          ? Center(
              child: Text("No Connections"),
            )
          : ListView(
              children: [
                for (var i in user)
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
                                child: Image.network("${i.img}"),
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
                                      title:
                                          Text("${i.firstName} ${i.lastName}"),
                                      subtitle: Text("${i.jobTitle}"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // TextButton(
                                        //   child: Text("Accept"),
                                        //   onPressed: () {},
                                        // ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        TextButton(
                                          child: Text("Message"),
                                          onPressed: () {},
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
