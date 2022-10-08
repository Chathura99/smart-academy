import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  ForumPage({required this.title});

  final String title;

  @override
  _ForumPageState createState() => new _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  static final listItemsData = [
    ListEntry("Forum 1", "test", "description 1", 54, 2, true),
    ListEntry("Forum 2", "test", "description 2", 154, 3, false),
    ListEntry("Forum 3", "test", "description 3", 971, 0, false),
    ListEntry("Forum 4", "test", "description 4", 124, 2, true),
  ];

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
  final String title;
  final String icon;
  final String description;
  final int views;
  final int responses;
  final bool answered;

  ListEntry(this.title, this.icon, this.description, this.views, this.responses,
      this.answered);
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
          Navigator.pushNamed(context, '/forum/1');
        },
      ),
    );
  }
}
