import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Center(
              child: Container(
                child: Image.asset(
                  '/profile.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Text(
                    'Chathura Manohara',
                    style: TextStyle(
                      color: Color.fromRGBO(39, 105, 171, 1),
                      fontSize: 27,
                    ),
                  ),
                  Text(
                    'Hello Student!',
                    style: TextStyle(
                      color: Color.fromRGBO(39, 105, 171, 1),
                      fontSize: 15,
                    ),
                  ),
                  Divider(
                    thickness: 2.5,
                  ),
                  Text("School : Maliyadeva College"),
                  Text("Grade : 6")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
