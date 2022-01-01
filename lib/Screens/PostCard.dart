import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:linked_in/src/MainPageScreen.dart';
// import 'package:linked_in/widgets/appButtons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Model/post.dart';

class PostCard extends StatefulWidget {
  @override
  _PostCardState createState() => _PostCardState();
  // final Post post;
  // PostCard(this.post);
}

class _PostCardState extends State<PostCard> {
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

  List posts = [];

  getPosts() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("Posts")
          .get()
          .then((value) => value.docs.forEach((element) {
                Post model = Post.fromJson(element.data());
                posts.add({"id": element.id, "data": model});
              }));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 10),
          height: 500,
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
                              foregroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHBlcnNvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                              backgroundColor: Colors.grey[350],
                              minRadius: 30),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "Ahmed Emad",
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "25",
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text("eee"
                    // style: TextStyle(fontWeight: FontWeight.w600),
                    ),
              ),
              Container(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Container(
                    child: Text(
                      "${posts[0].body}",
                      overflow: TextOverflow.fade,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.grey[350]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  //   crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: FaIcon(
                            FontAwesomeIcons.thumbsUp,
                            size: 15,
                            color: Colors.blue,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        ),
                        Container(
                          child: FaIcon(
                            FontAwesomeIcons.heart,
                            size: 15,
                            color: Colors.red,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        ),
                        Container(
                          child: FaIcon(
                            FontAwesomeIcons.share,
                            size: 15,
                            color: Colors.blue,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        ),
                        Text(
                          '147',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    Text('4 comments')
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: IconButton(
                          // label: "Like",
                          icon: Icon(Icons.notifications),
                          onPressed: () {})),
                  Flexible(
                      child: IconButton(
                          // label: "Comment",
                          icon: Icon(Icons.mode_comment_sharp),
                          // icon: FontAwesomeIcons.comments,
                          onPressed: () {})),
                  Flexible(
                      child: IconButton(
                          // label: "Share",
                          icon: Icon(Icons.share_location),
                          // icon: FontAwesomeIcons.share,
                          onPressed: () {})),
                  Flexible(
                      // child: AppButton(
                      //     label: "Send", icon: Icons.send, onPress: () {})),
                      child: IconButton(
                          // label: "Share",
                          icon: Icon(Icons.send),
                          // icon: FontAwesomeIcons.share,
                          onPressed: () {})),
                ],
              )
            ],
          )),
    );
  }
}
