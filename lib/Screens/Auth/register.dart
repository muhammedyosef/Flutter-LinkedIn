// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:linked_in/Screens/Auth/registerName.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String pw = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email Address'),
            ),
          ),
          Container(
            // padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: EdgeInsets.all(10),

            child: TextField(
              onChanged: (value) {
                pw = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              // style: ,
              onPressed: () async {
                await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(email: email, password: pw);
                setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterName()),
                );
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
