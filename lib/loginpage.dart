import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  late String _role;

  // TextEditingController nameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(66, 238, 252, 250),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1509228627152-72ae9ae6848d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1hdGhlbWF0aWNzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                fit: BoxFit.cover)),
        padding: EdgeInsets.only(top: 50.0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Welcome to Smart Academy!',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 60, 108),
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    // controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    }),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                    obscureText: true,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    }),
              ),
              Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      // print(nameController.text);
                      // print(passwordController.text);
                      // print("pw:"+_password+ "| email :" +_email);
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((user) {
                        // Query for get user role
                        CollectionReference currentUser =
                            FirebaseFirestore.instance.collection('users');
                        FirebaseFirestore.instance
                            .collection('users')
                            .where('email', isEqualTo: _email)
                            .get()
                            .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            print(doc["role"]);
                            setState(() {
                              _role = doc["role"];
                            });
                            if (_role == "student") {
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            } else if (_role == "teacher") {
                              Navigator.of(context)
                                  .pushReplacementNamed('/teacherhome');
                            }
                          });
                        });
                        // save user email in sharedpref

                        saveUserEmail() async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("useremail", _email);
                        }

                        saveUserEmail();
                        // redirect home page based on user
                      }).catchError((e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert(context);
                          },
                        );
                        // print(e);
                      });
                    },
                  )),
              Padding(
                padding: EdgeInsets.only(top: 150.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Create AlertDialog for invalid credentials
AlertDialog alert(context) => AlertDialog(
      title: Text("Login failed!"),
      content: Text("Invalid credentials."),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.all(5),
            child: const Text("OK"),
          ),
        ),
      ],
    );
