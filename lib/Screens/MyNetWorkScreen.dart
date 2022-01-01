// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:linked_in/screens/user_card.dart';
// import 'package:linked_in/widgets/appButtons.dart';

class MyNetWorkScreen extends StatefulWidget {
  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<MyNetWorkScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton.icon(
              label: Text("Manage my networks"),
              icon: Icon(Icons.camera),
              onPressed: () {}),
          SizedBox(
            height: 10,
            width: 100,
          ),
          // FullWidthButton(label: 'Invitations', onPress: () {}),
          TextButton.icon(
              label: Text("Invitations"),
              icon: Icon(Icons.camera),
              onPressed: () {}),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              UserCard(),
              UserCard(),
              UserCard(),
              UserCard(),
              UserCard(),
              UserCard(),
              UserCard(),
              UserCard(),
            ],
            spacing: 10,
            runSpacing: 10,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
