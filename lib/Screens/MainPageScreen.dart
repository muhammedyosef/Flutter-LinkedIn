// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linked_in/Screens/Model/comment.dart';
import 'package:linked_in/screens/PostCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import 'Model/Userss.dart';
import 'Model/post.dart';

class MainPageScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MainPageScreen> {
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

  void _commentModalBottomSheet(context, i) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext BC) {
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.all(10),
            height: 150,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    comm = value;
                  },
                  maxLines: 1,
                  decoration:
                      InputDecoration.collapsed(hintText: "Enter your Comment"),
                ),
                ElevatedButton(
                  child: Text("Comment"),
                  onPressed: () {
                    Welcome model = Welcome.fromJson(User);
                    realUser = model;

                    var comment = {
                      "ID": realUser.ID,
                      "Name": realUser.firstName,
                      "title": realUser.jobTitle,
                      "body": comm,
                      "img": realUser.img,
                      "IDD": i.idi,
                    };
                    FirebaseFirestore.instance
                        .collection("comment")
                        .add(comment);

                    // for (var i in posts) {
                    //   for (var index in comments) {
                    //     FirebaseFirestore.instance
                    //         .collection("Posts")
                    //         .get()
                    //         .then((value) => value.docs.forEach((element) {
                    //               Post model = Post.fromJson(element.data());
                    //               var x = model;
                    //               posts.add(model);
                    //               data = false;
                    //               FirebaseFirestore.instance
                    //                   .collection("comment")
                    //                   .doc(i.idi)
                    //                   .update(index);
                    //             }));
                    //   }
                    // }
                    setState(() {});
                  },
                )
              ],
            ),
          );
        });
  }

  List posts = [];
  List comments = [];
  bool data = true;
  var likes = 0;
  var comm = "";
  var User;
  var realUser;

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
    setState(() {});
  }

  getPosts() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("Posts")
          .get()
          .then((value) => value.docs.forEach((element) {
                Post model = Post.fromJson(element.data());
                posts.add(model);
                data = false;
                setState(() {});
              }));
    });
  }

  getComments() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("comment")
          .get()
          .then((value) => value.docs.forEach((element) {
                Comment model = Comment.fromJson(element.data());
                comments.add(model);
                data = false;
                setState(() {});
              }));
    });
  }

  @override
  void initState() {
    super.initState();
    getPosts();
    getOneUser();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreatAppBar(),
      body: SingleChildScrollView(
        child: data
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  for (var i in posts)
                    Card(
                        child: SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          margin: EdgeInsets.only(top: 10),
                          height: MediaQuery.of(context).size.height,
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
                                          CircleAvatar(
                                              foregroundImage:
                                                  NetworkImage("${i.img}"),
                                              backgroundColor: Colors.grey[350],
                                              minRadius: 30),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${i.Name}",
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  "${i.title}",
                                                ),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                            margin: EdgeInsets.only(left: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.notifications),
                                      onPressed: () {
                                        _settingModalBottomSheet(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "${i.body}",
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                decoration:
                                    BoxDecoration(color: Colors.grey[350]),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Container(
                                        //   child: FaIcon(
                                        //     FontAwesomeIcons.thumbsUp,
                                        //     size: 15,
                                        //     color: Colors.blue,
                                        //   ),
                                        //   margin: EdgeInsets.symmetric(
                                        //       horizontal: 5),
                                        // ),
                                        Container(
                                          child: IconButton(
                                              icon: Icon(
                                                FontAwesomeIcons.heart,
                                                color: Colors.red,
                                                size: 15,
                                              ),
                                              onPressed: () {
                                                Welcome model =
                                                    Welcome.fromJson(User);
                                                realUser = model;
                                                setState(() {
                                                  if (likes == 0) {
                                                    likes++;
                                                  } else if (likes == 1) {
                                                    likes--;
                                                  }
                                                  print(likes);
                                                });
                                                // icon:
                                                // Icon(FontAwesomeIcons.solidHeart);
                                              }),
                                          // FaIcon(
                                          //   FontAwesomeIcons.heart,
                                          //   size: 15,
                                          //   color: Colors.red,
                                          // ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                        ),
                                        // Container(
                                        //   child: FaIcon(
                                        //     FontAwesomeIcons.share,
                                        //     size: 15,
                                        //     color: Colors.blue,
                                        //   ),
                                        //   margin: EdgeInsets.symmetric(
                                        //       horizontal: 5),
                                        // ),
                                        Text(
                                          "${likes}",
                                          // "10",
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                    // Text("${i.comments} comments")
                                    // Text(" comments")
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                      child: IconButton(
                                          icon: Icon(Icons.notifications),
                                          onPressed: () {})),
                                  Flexible(
                                      child: IconButton(
                                          icon: Icon(Icons.mode_comment_sharp),
                                          onPressed: () {
                                            _commentModalBottomSheet(
                                                context, i);
                                          })),
                                  Flexible(
                                      child: IconButton(
                                          icon: Icon(Icons.share_location),
                                          onPressed: () {})),
                                  Flexible(
                                      child: IconButton(
                                          icon: Icon(Icons.send),
                                          onPressed: () {})),
                                ],
                              ),
                              SingleChildScrollView(
                                child: Container(
                                    child: data
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Column(
                                            children: [
                                              for (var index in comments)
                                                if (index.IDD == i.idi)
                                                  Card(
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          height: 80,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            10,
                                                                            10,
                                                                            10,
                                                                            0),
                                                                child: Row(
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          CircleAvatar(
                                                                              foregroundImage: NetworkImage("${index.img}"),
                                                                              backgroundColor: Colors.grey[350],
                                                                              minRadius: 20),
                                                                          Container(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Text(
                                                                                  "${index.Name}",
                                                                                  overflow: TextOverflow.fade,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                ),
                                                                                Text(
                                                                                  "${i.title}",
                                                                                ),
                                                                              ],
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                            ),
                                                                            margin:
                                                                                EdgeInsets.only(left: 10),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 50),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Text(
                                                                                  "${index.body}",
                                                                                  overflow: TextOverflow.fade,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                            ],
                                                          )))
                                            ],
                                          )),
                              )
                            ],
                          )),
                    ))
                ],
              ),
      ),
    );
  }
}
