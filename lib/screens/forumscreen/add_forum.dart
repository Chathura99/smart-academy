import 'package:flutter/material.dart';

class AddForum extends StatefulWidget {
  const AddForum({Key? key}) : super(key: key);

  @override
  State<AddForum> createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  late String _title;
  late String _description;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
                      'New Forum',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _title = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      obscureText: true,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _description = value;
                        });
                      }),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Publish'),
                      onPressed: () {
                        print(titleController.text);
                        print(descriptionController.text);
                      },
                    )),
              ],
            )));
  }
}

// Create AlertDialog
AlertDialog alert = AlertDialog(
  title: Text("Success!"),
  content: Text("Artical successfully added"),
);
