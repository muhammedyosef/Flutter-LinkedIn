import 'package:flutter/material.dart';
import 'package:linked_in/Screens/Manage/Connections.dart';

class Manage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Manage my network",
          ),
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Connections()));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Center(
                        child: Text(
                      "Connections",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
