import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ims/screens/forumscreen/add_forum_reply.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:shared_preferences/shared_preferences.dart';

class ForumDetailPage extends StatefulWidget {
  @override
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

var ForumPostReplyArr = [
  // ForumPostEntry("Chathura Manohara", "2022-10-08 22:10",
  //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit,in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint."),
  // ForumPostEntry("Nipuna Manujaya", "2022-10-10 02:12",
  //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt u."),
];

class _ForumDetailPageState extends State<ForumDetailPage> {
  late String _reply;

  TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // get forum id from headings page
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    print("Clicked->" + arguments['forumid']);

    void getForums(String forumid) async {
      ForumPostReplyArr.clear();
      print("came");
      var document = await FirebaseFirestore.instance
          .collection('forums')
          .doc(forumid)
          .get()
          .then((value) {
        // ForumPostReplyArr.add(value.data()!['reply']);
        var replies = value.data()!['reply'];

        // print(replies);
        for (var item in replies) {
          print(item);
          setState(() {
            ForumPostReplyArr.add(ForumPostEntry(
              item["username"],
              DateTime.parse(item["hour"].toDate().toString()).toString(),
              item["text"],
            ));
          });
        }
      }).catchError((error) {
        // if no replies
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertnodata(context);
          },
        );
      });
    }

    @override
    void initState() {
      super.initState();
    }

    var questionSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            "How do I become a expert in programming as well as design ??",
            textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                // controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Reply',
                ),
                onChanged: (value) {
                  setState(() {
                    _reply = value;
                  });
                },
                controller: replyController),
          ),
          ElevatedButton(
            child: const Text('Send'),
            onPressed: () {
              addReply(arguments['forumid'],replyController.text, context);
              print(replyController.text);
            },
          ),
          Divider(),
          ElevatedButton(
              onPressed: () {
                getForums(arguments['forumid']);
              },
              child: Text("View Replies"))
        ],
      ),
    );

    var responses = Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              ForumPost(ForumPostReplyArr[index]),
          itemCount: ForumPostReplyArr.length,
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Forum 1"),
        backgroundColor: Color.fromRGBO(39, 105, 171, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ForumPostReplyArr.clear();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          questionSection,
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: responses,
          ))
        ],
      ),
    );
  }
}

class ForumPostEntry {
  final String username;
  final String hours;
  final String text;

  ForumPostEntry(this.username, this.hours, this.text);
}

class ForumPost extends StatelessWidget {
  final ForumPostEntry entry;

  ForumPost(this.entry);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(39, 105, 171, 1),
        borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(39, 105, 171, 1),
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0)),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 40.0,
                  color: Colors.white,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        entry.username,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        entry.hours,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          print("deleted!");
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: IconButton(
                    //     icon: Icon(Icons.edit_note, color: Colors.white),
                    //     onPressed: () {
                    //       print("edited!");
                    //     },
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0))),
            child: Text(entry.text),
          ),
        ],
      ),
    );
  }
}

// Create AlertDialog fro empty reply
AlertDialog alertnodata(context) => AlertDialog(
      title: Text("Empty!"),
      content: Text("No replies yet."),
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

// add reply part

void addReply(String id,String text, BuildContext context) async {
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
  FirebaseFirestore.instance.collection('forums').doc(id).update({'reply':[
    {'text': text,
    'username': name,
    'hour': DateTime.now()}
  ]}).then((value) {
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
      content: Text("Reply successfully added."),
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
