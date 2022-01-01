// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Model/Userss.dart';
import 'Model/post.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.save),
                    title: Text('Save'),
                    onTap: () => {}),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.remove_red_eye_outlined),
                  title: Text('Who else can this post?'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.flag),
                  title: Text('Report'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  List Users = [];
  var User;
  var realUser;
  var Post;
  String tx = "";
  String con = "";
  var id;

  getOneUser() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(event?.uid)
          .get()
          .then((value) => User = value.data());
    });
    Welcome model = Welcome.fromJson(User);
    realUser = model;
    Users.add(realUser);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOneUser();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //     foregroundImage: NetworkImage(
                          //         "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                          //     backgroundColor: Colors.grey[350],
                          //     minRadius: 30),
                          // Container(
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         // "${realUser.ID}",
                          //         "khalil",
                          //         overflow: TextOverflow.fade,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 20),
                          //       ),
                          //       Text(
                          //         "Frontend Developer",
                          //       ),
                          //     ],
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //   ),
                          //   margin: EdgeInsets.only(left: 10),
                          // ),
                        ],
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.notifications),
                    //   onPressed: () {
                    //     Welcome model = Welcome.fromJson(User);
                    //     realUser = model;
                    //     _settingModalBottomSheet(context);
                    //     print(realUser.ID);
                    //   },
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Container(
                    child: TextField(
                      onChanged: (value) {
                        tx = value;
                      },
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "Enter your text here",
                          contentPadding: const EdgeInsets.all(20.0)),
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.grey[350]),
              ),
              Container(
                padding: const EdgeInsets.only(left: 240, top: 5),
                child: ElevatedButton(
                  child: Text("Post"),
                  onPressed: () {
                    Welcome model = Welcome.fromJson(User);
                    realUser = model;
                    var post = {
                      "ID": realUser.ID,
                      "Name": realUser.firstName,
                      "title": realUser.title,
                      "body": tx,
                    };
                    FirebaseFirestore.instance.collection("Posts").add(post);
                  },
                ),
              )
            ],
          )),
    );
  }
}
