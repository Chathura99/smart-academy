import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ims/screens/quizscreen/quiz_screen.dart';

class QuizMenu extends StatefulWidget {
  const QuizMenu({Key? key}) : super(key: key);

  @override
  _QuizMenuState createState() => _QuizMenuState();
}

class _QuizMenuState extends State<QuizMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Let's try!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    Center(
                      child: RawMaterialButton(
                        onPressed: () {
                          //Navigating the the Quizz Screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizzScreen(1),
                              ));
                        },
                        shape: const StadiumBorder(),
                        fillColor: Color.fromRGBO(39, 105, 171, 1),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: Text(
                            "Quiz 01",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
