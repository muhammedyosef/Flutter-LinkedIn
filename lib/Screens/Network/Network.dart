import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linked_in/Screens/Invitations/Invite.dart';
import 'package:linked_in/Screens/Manage/Manage.dart';
import 'package:linked_in/Screens/Model/Userss.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Network extends StatefulWidget {
  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  List Users = [];
  List Users1 = [];
  var User;
  var realUser;
  var id;
  getMyUsers() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((value) => value.docs.forEach((element) {
              Welcome model = Welcome.fromJson(element.data());
              Users.add(model);
            }));
    setState(() {});
  }

  getOneUser() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(event?.uid)
          .get()
          .then((value) => User = value.data());
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMyUsers();
    getOneUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Manage()));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Center(
                      child: Text(
                    "Manage my network",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Invite()));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Center(
                      child: Text(
                    "Invitations",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ),
            ),
          ),
          // Card(
          //   child: Container(
          //     height: 100,
          //     color: Colors.white,
          //     child: Row(
          //       children: [
          //         Center(
          //           child: Padding(
          //             padding: EdgeInsets.all(10),
          //             child: Expanded(
          //               child: Image.network("${Users[0].img}"),
          //               flex: 2,
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           child: Container(
          //             alignment: Alignment.topLeft,
          //             child: Column(
          //               children: [
          //                 Expanded(
          //                   flex: 5,
          //                   child: ListTile(
          //                     title: Text(
          //                         "${Users[0].firstName} ${Users[0].lastName} "),
          //                     subtitle: Text("${Users[0].jobTitle}"),
          //                   ),
          //                 ),
          //                 Expanded(
          //                   flex: 5,
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.end,
          //                     children: [
          //                       // TextButton(
          //                       //   child: Text("PLAY"),
          //                       //   onPressed: () {},
          //                       // ),
          //                       SizedBox(
          //                         width: 8,
          //                       ),
          //                       TextButton(
          //                         child: Text("Connect"),
          //                         onPressed: () {},
          //                       ),
          //                       SizedBox(
          //                         width: 8,
          //                       )
          //                     ],
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //           flex: 8,
          //         ),
          //       ],
          //     ),
          //   ),
          //   elevation: 8,
          //   margin: EdgeInsets.all(10),
          // ),

          for (var i in Users)
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
                                title: Text("${i.firstName} ${i.lastName} "),
                                subtitle: Text("${i.jobTitle}"),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // TextButton(
                                  //   child: Text("PLAY"),
                                  //   onPressed: () {},
                                  // ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  TextButton(
                                    child: Text("Connect"),
                                    onPressed: () {
                                      Welcome model = Welcome.fromJson(User);
                                      realUser = model;
                                      var notification = {
                                        "sendTo": i.ID,
                                        "sendFrom": realUser.ID,
                                        "img": realUser.img,
                                        "firstname": realUser.firstName,
                                        "lastname": realUser.lastName,
                                        "dateTime": new DateTime.now(),
                                        "status": 'Pending',
                                      };
                                      FirebaseFirestore.instance
                                          .collection("notifications")
                                          .add(notification);
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
