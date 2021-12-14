import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linked_in/Screens/Network/Network.dart';

class RegisterEmployee extends StatefulWidget {
  @override
  _RegisterEmployeeState createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
  String jobTitle = "";
  String company = "";
  String employmentType = "";
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
                jobTitle = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Job Title'),
            ),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.all(10),

            child: TextField(
              onChanged: (value) {
                company = value;
              },
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Company',
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.all(10),

            child: TextField(
              onChanged: (value) {
                employmentType = value;
              },
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Employee Type',
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
                    "jobTitle": jobTitle,
                    "company": company,
                    "employmentType": employmentType
                  }, SetOptions(merge: true));
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Network()));
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
