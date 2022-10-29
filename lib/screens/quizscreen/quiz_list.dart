import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  void initState() {
    getQuestions();
    super.initState();
  }

  void getQuestions() async {
    await FirebaseFirestore.instance
        .collection('questions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          QuestionArr.add({
            doc.get("question"),
            // get question from index
            doc.get("ans1"), doc.get("ans2"), doc.get("ans3"), doc.get("ans4"),
            // doc.id,
          });
        });
      });
    });
  }

  var QuestionArr = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Question List",
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: QuestionArr.length,
            itemBuilder: (BuildContext context, int index) => Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 245, 245),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(5.0)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(5.0),
                          topRight: const Radius.circular(5.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                "Question :",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child:
                                  // Icon(Icons.delete, color: Colors.black),
                                  IconButton(
                                icon: Icon(Icons.delete, color: Colors.black),
                                onPressed: () {
                                  print("deleted->" +
                                      QuestionArr[index].toList()[5]);
                                  // delete query
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 2.0, right: 2.0, bottom: 2.0),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(QuestionArr[index].toList()[0]),
                        Text(QuestionArr[index].toList()[1]),
                        Text(QuestionArr[index].toList()[2]),
                        Text(QuestionArr[index].toList()[3]),
                        Text(QuestionArr[index].toList()[4]),
                        // Text(QuestionArr[index].toList()[5]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
