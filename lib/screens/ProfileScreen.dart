import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  var type = "student";
  //To Do:  show data with selected user role part
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
                  type == "student"
                      ? Text(
                          'Hello Student!',
                          style: TextStyle(
                            color: Color.fromRGBO(39, 105, 171, 1),
                            fontSize: 15,
                          ),
                        )
                      : Text(
                          'Hello Teacher!',
                          style: TextStyle(
                            color: Color.fromRGBO(39, 105, 171, 1),
                            fontSize: 15,
                          ),
                        ),
                  Divider(
                    thickness: 2.5,
                  ),
                  Text("School : Maliyadeva College"),
                  Text("Grade : 6"),
                  Divider(
                    thickness: 2.5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("edited!");
                      },
                      child: Text("Edit"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
