import 'package:assignment_jit/tabs/transactionDetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions extends StatefulWidget {
  final snap;
  const Transactions({super.key, required this.snap});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  String? transactionId;
  String? type;
  String? amount;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TransactionDetails(
                          index: widget.snap['transactionId'],
                        )));
              },
              child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(
                      widget.snap['transactionId'],
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        widget.snap['amount'],
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    trailing: Text(
                      widget.snap['type'],
                      style: const TextStyle(
                          fontSize: 13, color: Color.fromARGB(255, 84, 84, 84)),
                    ),
                  )),
            ),
            const Divider(
              color: Color.fromARGB(255, 176, 175, 170),
            )
          ],
        ));
  }
}
