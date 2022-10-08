import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ims/homepage.dart';
import 'package:ims/screens/ProfileScreen.dart';
import 'package:ims/screens/articalscreen/add_artical.dart';
import 'package:ims/screens/forumscreen/forum.dart';
import 'package:ims/screens/forumscreen/forum_detail.dart';
import 'package:ims/signuppage.dart';

import './loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCDm_lfV4bncBWSQ2KTYrorwjxhlyhvVoM",
      appId: "1:664184116638:android:d1adacc73a0b47e2a5728f",
      messagingSenderId: "664184116638",
      projectId: "unity-academy",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Academy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context) => const MyApp(),
        '/signup': (BuildContext context) => const SignUpPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/profilepage' : (BuildContext context) => ProfileScreen(),
        '/forum': (BuildContext context) => ForumPage(title: 'Forum',),
         '/forum/1': (BuildContext context) => ForumDetailPage(),
         '/addarticle': (BuildContext context) => const AddArtical(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
