import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ims/screens/articalscreen/artical.dart';
import 'package:ims/screens/classfee/payment.dart';
import 'package:ims/screens/forumscreen/forum.dart';
import 'package:ims/screens/quizscreen/quiz_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var type = "student";
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Smart Academy",
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              //
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacementNamed(context, '/landingpage');
                }).catchError((e) {
                  print(e);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.people),
              onPressed: () {
                Navigator.pushNamed(context, '/profilepage');
              },
            ),
          ],
          flexibleSpace: Image.asset(
            "assets/background.jpeg",
            fit: BoxFit.cover,
          ),
          bottom: PreferredSize(
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.quiz_rounded),
                ),
                Tab(
                  icon: Icon(Icons.forum),
                ),
                Tab(
                  icon: Icon(Icons.article),
                ),
                Tab(
                  icon: Icon(Icons.payment),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(50),
          ),
        ),
        body: TabBarView(
          children: [
            //tab 1
            QuizMenu(),
            //tab 2
            ForumPage(title: 'dge'),
            //tab 3
            ArticalPage(),
            // tab 4
            Payment()
          ],
        ),
      ),
    );
  }
}
