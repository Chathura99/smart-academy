import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

var _name;
var _type;
var _email;

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    retrieveUserEmail();
    // getProfileData();
    super.initState();
  }

  retrieveUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString("useremail") ?? "";
    // set user's email
    setState(() {
      _email = value;
    });
    // set user's name
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _name = doc["name"];
          _type = doc['role'];
        });
      });
    });
  }

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
                    _name,
                    style: TextStyle(
                      color: Color.fromRGBO(39, 105, 171, 1),
                      fontSize: 27,
                    ),
                  ),
                  _type == "student"
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
                  // Text("School : Maliyadeva College"),
                  // Text("Grade : 6"),
                  Text("Email : ${_email}"),
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

// void getProfileData() async {
//   // get email
//   var usermail = await retrieveUserEmail();
//   print(usermail);
//   // get username

//   var name = "";
//   await FirebaseFirestore.instance
//       .collection('users')
//       .where('email', isEqualTo: usermail)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       name = doc["name"];
//     });
//   });

//   await FirebaseFirestore.instance
//       .collection('articles')
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     querySnapshot.docs.forEach((doc) {
//       // setState(() {
//       //   _name = doc['name'];
//       //   _role = doc['role'];
//       //   _email = doc['email'];
//       // });
//     });
//   });
// }
