import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linked_in/Screens/Invitations/Invite.dart';
import 'package:linked_in/Screens/Manage/Manage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linked_in/Screens/Model/jobs.dart';
import 'package:linked_in/Screens/jobs/job_detials.dart';

class Jobs extends StatefulWidget {
  // Jobs({this.Users[]})
  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  List jobs = [];
  var job;
  getMyUsers() async {
    await FirebaseFirestore.instance
        .collection('jobs')
        .get()
        .then((value) => value.docs.forEach((element) {
              JobsData model = JobsData.fromJson(element.data());
              jobs.add(model);
            }));
    setState(() {});
  }

  getOneUser() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      FirebaseFirestore.instance
          .collection("jobs")
          .doc(event?.uid)
          .get()
          .then((value) => job = value.data());
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMyUsers();
    getOneUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: ListView(
        children: [
          for (var i in jobs)
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.white,
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Expanded(
                          child: Text("${i.joptitle}",
                              style: TextStyle(fontSize: 20)),
                          flex: 3,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text("Name : ${i.namecompany}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text("Phone : ${i.PhoneCompany}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text("Contract: ${i.contract}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text("NoEmployee :${i.employees}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text("Location :${i.jopaddress}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text("Type: ${i.joptype}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text("Description : ${i.jobDesc}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                MaterialButton(
                                  // child: Text("Details"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobDetials(jobs)));
                                  },
                                )
                              ],
                            ),

                            // // ),
                            // // Expanded(
                            // //   flex: 5,
                            // //   child: Row(
                            // //     mainAxisAlignment: MainAxisAlignment.end,
                            // //     children: [
                            // //       SizedBox(
                            // //         width: 15,
                            // //       ),
                            // //       TextButton(
                            // //         child: Text("Save"),
                            // //         onPressed: () {
                            // //           JobsData model = JobsData.fromJson(User);
                            // //           realUser = model;
                            // //           var notification = {
                            // //             "sendTo": i.ID,
                            // //             "sendFrom": realUser.ID,
                            // //             "jobtitle": realUser.joptitle,
                            // //             "jopaddress": realUser.jopaddress,
                            // //             "dateTime": new DateTime.now(),
                            // //             "status": 'Pending',
                            // //           };
                            // //           FirebaseFirestore.instance
                            // //               .collection("notifications")
                            // //               .add(notification);
                            // //         },
                            // //       ),
                            // //       SizedBox(
                            //         width: 20,
                          )
                        ],
                      ),
                    )
                        // ],
                        ),
                    //   ),
                    //   flex: 40,
                    // ),
                  ],
                ),
              ),
              elevation: 48,
              margin: EdgeInsets.all(10),
            ),
        ],
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
