import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class ForumPage extends StatefulWidget {
  ForumPage({required this.title});

  final String title;

  @override
  _ForumPageState createState() => new _ForumPageState();
}

var listItemsData = [];

class _ForumPageState extends State<ForumPage> {
  @override
  void initState() {
    listItemsData = [];
    getForums();
    super.initState();
  }

  void getForums() async {
    await FirebaseFirestore.instance
        .collection('forums')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print(doc.id);
        setState(() {
          listItemsData.add(ListEntry(
            doc.id,
            doc["title"],
            doc["description"],
            doc["username"],
            DateTime.parse(doc["hour"].toDate().toString()).toString(),
          ));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Text(
            "Forums",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                EntryItem(listItemsData[index]),
            itemCount: listItemsData.length,
            shrinkWrap: true,
          ),
        ],
      )),
    );
  }

  void _onSearchPressed() {
    Navigator.pop(context);
  }
}

class ListEntry {
  final String id;
  final String title;
  final String description;
  final String name;
  final String date;
  ListEntry(this.id, this.title, this.description, this.name, this.date);
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final ListEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      decoration: new BoxDecoration(
        color: Color.fromRGBO(39, 105, 171, 1),
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      child: ListTile(
        title: Text(
          entry.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          entry.description,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: Icon(
          Icons.dashboard,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/forumdetails',arguments: {'forumid': entry.id,'forumtitle':entry.title});
          // print( '/forumdetails/${entry.id}');
        },
      ),
    );
  }
}
