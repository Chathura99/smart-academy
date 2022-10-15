import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:shared_preferences/shared_preferences.dart';

class AddForum extends StatefulWidget {
  const AddForum({Key? key}) : super(key: key);

  @override
  State<AddForum> createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  late String _title;
  late String _description;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
                      'New Forum',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _title = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _description = value;
                        });
                      }),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Publish'),
                      onPressed: () {
                        print(titleController.text);
                        print(descriptionController.text);
                        addForum(titleController.text,descriptionController.text,context);
                      },
                    )),
              ],
            )));
  }
}

void addForum(String title, String des, BuildContext context) async {
  // get email
  var usermail = await retrieveUserEmail();
  print(usermail);
  // get username

  var name = "";
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: usermail)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      name = doc["name"];
    });
  });

  print(name);
// save to database
  print(DateTime.now());
  FirebaseFirestore.instance.collection('forums').add({
    'description': des,
    'title': title,
    'username': name,
    'email': usermail,
    'hour': DateTime.now(),
    'reply': {}
  }).then((value) {
    // Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert(context);
      },
    );
  }).catchError((e) {
    print(e);
  });
}

// get email from shared pref
retrieveUserEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.getString("useremail") ?? "";
  return value;
}

// Create AlertDialog
AlertDialog alert(context) => AlertDialog(
      title: Text("Success!"),
      content: Text("Artical successfully added"),
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
