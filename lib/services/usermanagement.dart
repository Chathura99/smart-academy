import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Usermanagement {
  CollectionReference ref = FirebaseFirestore.instance.collection('/users');
  storeNewUser(UserCredential value, context) {
    var email = value.user!.email;
    var pw = value.user!.uid;
    ref.add({'email': email, 'password': pw}).then((value) {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/landingpage');
    }).catchError((e) {
      print(e);
    });
  }

  // getUserData() {
  //   ref.doc().get().then((value) => print(value.data));
  // }
}
