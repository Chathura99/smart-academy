import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SafeArea(
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Unity Academy",
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              //call method in here
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //call method
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacementNamed(context,'/landingpage');
                }).catchError((e) {
                  print(e);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                //call method
              },
            ),
          ],
          flexibleSpace: Image.asset(
            "assets/me1.png",
            fit: BoxFit.cover,
          ),
          bottom: PreferredSize(
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.add),
                  // text: "New",
                ),
                Tab(
                  icon: Icon(Icons.remove),
                  // text: "Remove",
                ),
                Tab(
                  icon: Icon(Icons.update),
                  // text: "Update",
                ),
              ],
            ),
            preferredSize: Size.fromHeight(50),
          ),
          //  backgroundColor: Colors.pinkAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: TabBarView(
            children: [
              //tab 1
              tab1(),
              //tab 2
              Container(
                  color: Color.fromARGB(96, 218, 216, 216),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Text("Remove Student")),
              //tab 3
              Text("Update Student Details"),
            ],
          ),
        ),
      ),
    );
    // );
  }
}

Widget tab1() {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    // crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text("Add new Student"),
      Text("List All"),
      Text("Show Detail"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.facebook,
              color: Colors.blue,
            ),
            onPressed: () {
              //call method
            },
          ),
          IconButton(
            icon: Icon(
              Icons.youtube_searched_for,
              color: Colors.red,
            ),
            onPressed: () {
              //call method
            },
          ),
          IconButton(
            icon: Icon(
              Icons.whatsapp,
              color: Colors.green,
            ),
            onPressed: () {
              //call method
            },
          ),
        ],
      ),
    ],
  );
}
