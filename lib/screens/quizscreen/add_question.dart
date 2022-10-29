import 'dart:async';

import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  late String _question;
  late String _ans1;
  late String _ans2;
  late String _ans3;
  late String _ans4;
  late String _ans;

  TextEditingController questionController = TextEditingController();
  TextEditingController ans1Controller = TextEditingController();
  TextEditingController ans2Controller = TextEditingController();
  TextEditingController ans3Controller = TextEditingController();
  TextEditingController ans4Controller = TextEditingController();
  TextEditingController ansController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'New Quiz',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                      controller: questionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Question',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _question = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      controller: ans1Controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '1st Answer',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _ans1 = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      controller: ans2Controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '2nd Answer',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _ans2 = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      controller: ans3Controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '3rd Answer',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _ans3 = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      controller: ans4Controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '4th Answer',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _ans4 = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      controller: ansController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correct Answer | 1 2 3 or 4',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _ans = value;
                        });
                      }),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Add'),
                    onPressed: () {
                      print(ans1Controller.text);
                      print(ans1Controller.text);
                      print(ans3Controller.text);
                      print(ans4Controller.text);
                      print(ansController.text);
                      print(ansController.text);

                      FirebaseFirestore.instance.collection('questions').add({
                        "question": questionController.text,
                        "ans1": ans1Controller.text,
                        "ans2": ans2Controller.text,
                        "ans3": ans3Controller.text,
                        "ans4": ans4Controller.text,
                        "ans1correctornot":
                            (ansController.text == "1") ? true : false,
                        "ans2correctornot":
                            (ansController.text == "2") ? true : false,
                        "ans3correctornot":
                            (ansController.text == "3") ? true : false,
                        "ans4correctornot":
                            (ansController.text == "4") ? true : false,
                      }).then((value) {
                        print("saved"); 
                      }).catchError((e) {
                        print(e);
                      });
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/quizlist');
                        },
                        child: Text("Go to Questions")))
              ],
            )));
  }
}

// Create AlertDialog
AlertDialog alert = AlertDialog(
  title: Text("Success!"),
  content: Text("Artical successfully added"),
);
