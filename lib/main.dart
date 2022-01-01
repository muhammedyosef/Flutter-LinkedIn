// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linked_in/Screens/Auth/login.dart';
import 'package:linked_in/Screens/Post.dart';
import 'package:linked_in/Screens/jobs/jobs.dart';
import 'package:linked_in/screens/MainPageScreen.dart';
import 'package:linked_in/screens/MyNetWorkScreen.dart';
import 'package:linked_in/screens/notifications_screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Screens/Model/Userss.dart';
import 'Screens/Network/Network.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); // run app
} // void main

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
  }
}

///////////////////////////////////// Bottom Navigation Bar

class JobsScreen extends StatelessWidget {
  get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreatAppBar(
        key: index,
      ),
      backgroundColor: Colors.yellow,
    );
  }
}

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreatAppBar(),
      backgroundColor: Colors.green,
    );
  }
}

class CreatNavigationBar extends StatefulWidget {
  static const route = "CreatNavigationBar";
  @override
  State<StatefulWidget> createState() => CreatNavigationBarState();
}

class CreatNavigationBarState extends State<CreatNavigationBar> {
  int _selectedIndex = 0;
  List<Widget> pages = <Widget>[
    MainPageScreen(),
    Network(),
    AddPost(),
    NotificationsScreen(),
    Jobs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(
            fontSize: 10, fontFamily: "cairo", fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
            fontSize: 10, fontFamily: "cairo", fontWeight: FontWeight.bold),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "My NetWork",
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: "Post",
            icon: Icon(Icons.add_box),
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            label: "Jobs",
            icon: Icon(Icons.work),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////// Upper Navigation Bar

class CreatAppBar extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize;
  // DocumentSnapshot User;
  // var realUser;
  // getOneUser() async {
  //   await FirebaseAuth.instance.authStateChanges().listen((event) {
  //     FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(event?.uid)
  //         .get()
  //         .then((value) => User = value.data() as DocumentSnapshot<Object>);
  //   });
  //   // setState(() {});
  //   Welcome model = Welcome.fromJson(User);
  //   realUser = model;
  // }

  CreatAppBar({
    Key key,
  })  : preferredSize = Size.fromHeight(80.0),
        super(key: key);

  // @override
  // void initState() {
  //   getOneUser();
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Expanded(
                child: Icon(
              Icons.message,
              color: Colors.grey,
              size: 25,
            )),
            Expanded(
              flex: 4,
              child: Container(
                  height: 45.54,
                  child: TextField(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black, fontSize: 18),

                      //onChanged: onChange,
                      //validator: validate,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey.shade50,
                        prefixText: ("search"),
                        //hintText: ("search"),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.search),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),

                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffE9E9E9), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),

                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ))),
            ),
            Expanded(
                child: CircleAvatar(
              radius: 25,
              // foregroundImage: NetworkImage("${User.d}"),
            ))
          ],
        ));
  }
}
