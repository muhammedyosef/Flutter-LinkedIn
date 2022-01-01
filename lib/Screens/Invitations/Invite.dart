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
  var obj;
  bool data = true;
  getRequests() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("notifications")
          .get()
          // ignore: avoid_function_literals_in_foreach_calls
          .then((value) => value.docs.forEach((element) {
                obj = element.data();
                obj["ID"] = element.id;
                Request model = Request.fromJson(obj);
                if (model.sendTo == event?.uid) {
                  requst.add(model);
                  data = false;
                  setState(() {});
                }
              }));
    });
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
      appBar: AppBar(
        title: const Text(
          "Invitation",
        ),
      ),
      body: data
          ? Center(
              child: Text("NO Requests"),
            )
          : ListView(
              children: [
                for (var i in requst)
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
                                          Text("${i.firstname}  ${i.lastname}"),
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
                                              "sendFrom": i.sendFrom,
                                              "sendTo": i.sendTo,
                                              "dateTime": new DateTime.now(),
                                            });
                                            FirebaseFirestore.instance
                                                .collection('notifications')
                                                .doc(i.ID)
                                                .delete();
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                          },
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        TextButton(
                                          child: Text("Reject"),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('notifications')
                                                .doc(i.ID)
                                                .delete();
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
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
