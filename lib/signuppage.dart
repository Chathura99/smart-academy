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
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Welcome to Smart Academy!',
                      style: TextStyle(
                          color: Colors.blue,
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
                        labelText: 'Username',
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
                Column(
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
                Container(
                    height: 50,
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
                            .then((value) => Usermanagement()
                                .storeNewUser(value, _role.toString(),_username.toString(), context))
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
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ],
            )));
  }
}

// Create AlertDialog
AlertDialog alert(e) => AlertDialog(
      title: Text("Sign up failed!"),
      content: Text(e.toString()),
    );
