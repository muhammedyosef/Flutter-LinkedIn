import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linked_in/Screens/Auth/registerEmployee.dart';

class RegisterCity extends StatefulWidget {
  @override
  _RegisterCityState createState() => _RegisterCityState();
}

class _RegisterCityState extends State<RegisterCity> {
  String country = "";
  String city = "";
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
                country = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Country'),
            ),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.all(10),

            child: TextField(
              onChanged: (value) {
                city = value;
              },
              // obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'City',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              // style: ,
              onPressed: () async {
                await FirebaseAuth.instance.authStateChanges().listen((event) {
                  users.doc(event?.uid).set({"country": country, "city": city},
                      SetOptions(merge: true));
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterEmployee()));
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
