import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: 250,
      width: width * 0.47,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: 75,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.green),
            ),
          ),
          Positioned(
            top: 35,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1553514029-1318c9127859?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODN8fHBvcnRyYWl0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                  radius: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('User Name'),
                Text('Designation'),
                IconButton(
                    // label: "Share",
                    icon: Icon(Icons.share_location),
                    // icon: FontAwesomeIcons.share,
                    onPressed: () {}),
              ],
            ),
          ),
        ],
        alignment: Alignment.topCenter,
      ),
    );
  }
}
