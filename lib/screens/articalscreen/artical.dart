import 'package:flutter/material.dart';

class ArticalPage extends StatefulWidget {
  @override
  _ArticalPageState createState() => _ArticalPageState();
}

var ForumPostArr = [
  ForumPostEntry("Chathura Manohara", "2022-10-08 22:10", 7, 1,
      "Earth and Water Lorem ipsum dolor sit amet, consectetur adipiscing elit,in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint."),
  ForumPostEntry("Chathura Manohara", "2022-10-08 22:10", 5, 0,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt u."),
];

class _ArticalPageState extends State<ArticalPage> {
  @override
  Widget build(BuildContext context) {
    var questionSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            "Articals",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_circle_outline_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/addarticle');
                  },
                ),
              ],
            ),
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
  final int likes;
  final int dislikes;
  final String text;

  ForumPostEntry(
      this.username, this.hours, this.likes, this.dislikes, this.text);
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
        borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(39, 105, 171, 1),
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(5.0),
                  topRight: const Radius.circular(5.0)),
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
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.thumb_up, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        entry.likes.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.thumb_down, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 2.0),
                      child: Text(
                        entry.dislikes.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
                      bottomLeft: const Radius.circular(5.0),
                      bottomRight: const Radius.circular(5.0))),
              child: Column(
                children: [Text("Title"),Image.asset('/earth.jpg'), Text(entry.text)],
              )),
        ],
      ),
    );
  }
}
