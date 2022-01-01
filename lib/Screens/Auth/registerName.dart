import 'package:flutter/material.dart';
import 'package:linked_in/Screens/Auth/registerCity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterName extends StatefulWidget {
  @override
  _RegisterNameState createState() => _RegisterNameState();
}

class _RegisterNameState extends State<RegisterName> {
  String firstName = "";
  String lastName = "";
  String ID = "";
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                firstName = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.all(10),

            child: TextField(
              onChanged: (value) {
                lastName = value;
              },
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Last Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              // style: ,
              onPressed: () async {
                await FirebaseAuth.instance.authStateChanges().listen((event) {
                  users.doc(event?.uid).set({
                    "ID": event?.uid,
                    "firstName": firstName,
                    "lastName": lastName
                  }, SetOptions(merge: true));
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterCity()));
              },
              // border: OutlineInputBorder(),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
