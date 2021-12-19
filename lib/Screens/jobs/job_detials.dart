import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetials extends StatefulWidget {
  List jobs = [];
  JobDetials(jobs);

  @override
  _JobDetialsState createState() => _JobDetialsState();
}

class _JobDetialsState extends State<JobDetials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        for (var i in widget.jobs)
          Card(
              child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.lightBlue,
            child: Row(children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Expanded(
                    child:
                        Text("${i.joptitle}", style: TextStyle(fontSize: 20)),
                    flex: 3,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        Expanded(
                            flex: 5,
                            child: ListView(children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("${i.namecompany}",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("${i.PhoneCompany}",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("${i.contract}",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("${i.employees}",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("${i.jopaddress}",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text("${i.joptype}",
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ])),
                      ])))
            ]),
          ))
      ],
    ));
  }
}
