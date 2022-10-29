import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:shared_preferences/shared_preferences.dart';


class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

enum Paymentmethod { credit, debit }

class _PaymentState extends State<Payment> {
  late String _cardNumber;
  late String _cvv;
  late String _expireDate;
  late String _amount;
  Paymentmethod? _method = Paymentmethod.debit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Text(
                  "Payments",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                      // controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card number | xxxx xxxx xxxx xxxx',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _cardNumber = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      // controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expiry date | mm/yy',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _expireDate = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      // controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV | xxx',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _cvv = value;
                        });
                      }),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      // controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount| xxxx.xx',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _amount = value;
                        });
                      }),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('debit'),
                      leading: Radio<Paymentmethod>(
                        value: Paymentmethod.debit,
                        groupValue: _method,
                        onChanged: (Paymentmethod? value) {
                          setState(() {
                            _method = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('credit'),
                      leading: Radio<Paymentmethod>(
                        value: Paymentmethod.credit,
                        groupValue: _method,
                        onChanged: (Paymentmethod? value) {
                          setState(() {
                            _method = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Pay Now'),
                      onPressed: () async {
                        // print(nameController.text);
                        // print(passwordController.text);
                        var _usermail = await retrieveUserEmail();
                        print("cvv:" +
                            _cvv +
                            "| card_no :" +
                            _cardNumber +
                            "| exp_date :" +
                            _expireDate);
                        print(_method.toString());
                        FirebaseFirestore.instance.collection('payments').add({
                          'amount': _amount,
                          'userEmail': _usermail,
                          'hour': DateTime.now(),
                          'method': _method.toString()
                        }).then((value) {
                          print("Payment Successful");
                        }).catchError((e) {
                          print(e);
                        });
                      },
                    )),
              ],
            )));
  }
}
retrieveUserEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.getString("useremail") ?? "";
  return value;
}