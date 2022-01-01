import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:linked_in/Screens/Auth/register.dart';
import 'package:linked_in/Screens/Network/Network.dart';
import 'package:linked_in/Screens/jobs/jobs.dart';
import 'package:linked_in/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    String email = "";
    String pw = "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Linked In'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Sign In',
              textAlign: TextAlign.center,
            ),
          ),
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
                    .signInWithEmailAndPassword(email: email, password: pw);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatNavigationBar()));
              },
              // border: OutlineInputBorder(),
              child: const Text('Login'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Jobs()),
                );
              },
              child: const Text(
                'No Account? Sign up',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
