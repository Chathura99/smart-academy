import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:shared_preferences/shared_preferences.dart';

class AddArtical extends StatefulWidget {
  const AddArtical({Key? key}) : super(key: key);

  @override
  State<AddArtical> createState() => _AddArticalState();
}

class _AddArticalState extends State<AddArtical> {
  late String _title;
  late String _content;
  late String _username;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Articals"),
            backgroundColor: Color.fromRGBO(39, 105, 171, 1)),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'New Articals',
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
                      controller: contentController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Content',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _content = value;
                        });
                      }),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Publish'),
                      onPressed: () {
                        addArticle(titleController.text, contentController.text,
                            context);
                      },
                    )),
              ],
            )));
  }
}

void addArticle(String title, String text, BuildContext context) async {
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
  FirebaseFirestore.instance.collection('articles').add({
    'text': text,
    'title': title,
    'like': 0,
    'unlike': 0,
    'username': name,
    'email': usermail,
    'hour': DateTime.now()
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
