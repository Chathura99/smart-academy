import 'package:flutter/material.dart';

class AddForumReply extends StatefulWidget {
  const AddForumReply({Key? key}) : super(key: key);

  @override
  State<AddForumReply> createState() => _AddForumReplyState();
}

class _AddForumReplyState extends State<AddForumReply> {
  late String _reply;

  TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'New Articals',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  child: TextField(
                      // controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _reply = value;
                        });
                      }),
                ),
               
                Container(
                    child: ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {
                        print(replyController.text);
                      },
                    )),
              ],
            );
  }
}