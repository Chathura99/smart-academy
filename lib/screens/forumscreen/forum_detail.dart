import 'package:flutter/material.dart';
import 'package:ims/screens/forumscreen/add_forum_reply.dart';

class ForumDetailPage extends StatefulWidget {
  @override
  _ForumDetailPageState createState() => _ForumDetailPageState();
}

var ForumPostArr = [
  ForumPostEntry("Chathura Manohara", "2022-10-08 22:10",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit,in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint."),
  ForumPostEntry("Nipuna Manujaya", "2022-10-10 02:12",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt u."),
];

class _ForumDetailPageState extends State<ForumDetailPage> {
  late String _reply;

  TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              print(replyController.text);
            },
          ),
          Divider()
        ],
      ),
    );

    var responses = Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              ForumPost(ForumPostArr[index]),
          itemCount: ForumPostArr.length,
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Forum 1"),
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: Icon(Icons.edit_note, color: Colors.white),
                        onPressed: () {
                          print("edited!");
                        },
                      ),
                    ),
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
