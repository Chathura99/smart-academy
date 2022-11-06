import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ims/services/usermanagement.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum Userrole { student, teacher }

class _SignUpPageState extends State<SignUpPage> {
  late String _email;
  late String _password;
  late String _username;
  Userrole? _role = Userrole.teacher;

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
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        // controller: nameController,
                        decoration: const InputDecoration(
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
                        // controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _username = value;
                          });
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                        obscureText: true,
                        // controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Teacher'),
                          leading: Radio<Userrole>(
                            value: Userrole.teacher,
                            groupValue: _role,
                            onChanged: (Userrole? value) {
                              setState(() {
                                _role = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Student'),
                          leading: Radio<Userrole>(
                            value: Userrole.student,
                            groupValue: _role,
                            onChanged: (Userrole? value) {
                              setState(() {
                                _role = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 40,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          // print(nameController.text);
                          // print(passwordController.text);
                          print("pw:" + _password + "| email :" + _email);
                          print(_role.toString());
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((value) => Usermanagement().storeNewUser(
                                  value,
                                  _role.toString(),
                                  _username.toString(),
                                  context))
                              // print(value))
                              .catchError((e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert(e);
                              },
                            );
                          });
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Do you have an account?'),
                      TextButton(
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}

// Create AlertDialog
AlertDialog alert(e) => AlertDialog(
      title: Text("Sign up failed!"),
      content: Text(e.toString()),
    );
