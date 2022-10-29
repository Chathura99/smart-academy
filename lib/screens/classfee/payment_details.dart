import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

var listItemsData = [];

class _PaymentDetailsState extends State<PaymentDetails> {
  @override
  void initState() {
    // listItemsData = [];
    getPayments();
    super.initState();
  }

  void getPayments() async {
    await FirebaseFirestore.instance
        .collection('payments')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print(doc.id);
        setState(() {
          listItemsData.add(ListEntry(
              doc["userEmail"], doc["amount"] + " Rs", "2022-10-12 12:56:85"
              // doc["hour"]
              ));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Text(
            "Payment Records",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                EntryItem(listItemsData[index]),
            itemCount: listItemsData.length,
            shrinkWrap: true,
          ),
        ],
      )),
    );
  }
}

class ListEntry {
  final String user;
  final String amount;
  final String date;
  ListEntry(this.user, this.amount, this.date);
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final ListEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      decoration: new BoxDecoration(
        color: Color.fromRGBO(39, 105, 171, 1),
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      child: ListTile(
        title: Text(
          entry.date,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          entry.user,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: Text(
          entry.amount,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
