import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuizList extends StatefulWidget {
  const QuizList({Key? key}) : super(key: key);

  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  var QuestionArr = [
    {"Q1", "e", "f", "g", "h"},
    {"Q2", "a", "b", "c", "d"},
    {"Q3", "e", "f", "g", "h"},
    {"Q4", "a", "b", "c", "d"},
    {"Q5", "e", "f", "g", "h"},
    {"Q4", "a", "b", "c", "d"},
  ];
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
                        
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(Icons.delete, color: Colors.black),
                              
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
