import 'package:assignment_jit/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:assignment_jit/models/transactionmodel.dart' as model;

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key, required this.index});

  final String index;

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState(index);
}

class _TransactionDetailsState extends State<TransactionDetails> {
  String? transactionId = "";
  String? amount = "";
  String? type = "";
  String? index = "";
  String? commission;
  String? date;
  String? total;

  _TransactionDetailsState(this.index);
  final db = FirebaseFirestore.instance;

  void getData() async {
    final ref = db.collection("transactions").doc(index).withConverter(
          fromFirestore: model.transactionModel.fromFirestore,
          toFirestore: (model.transactionModel transaction, _) =>
              transaction.toFirestore(),
        );
    final docSnap = await ref.get();
    final transactionData = docSnap.data();
    if (transactionData != null) {
      transactionId = transactionData.transactionId;
      amount = transactionData.amount;
      type = transactionData.type;
      commission = transactionData.commission;
      date = transactionData.date;
      total = transactionData.total;
    } else {
      print("No such document.");
    }
    setState(() {});
  }

  @override
  void initState() {
    setState(() {});
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 212, 212),
      appBar: AppBar(
        title: const Text("Transaction Details"),
        backgroundColor: const Color.fromARGB(255, 245, 202, 72),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Transaction No: $transactionId",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "Type: $type",
              style: const TextStyle(
                  color: Color.fromARGB(255, 50, 48, 48), fontSize: 20),
            ),
            Text(
              "Amount: $amount",
              style: const TextStyle(
                  color: Color.fromARGB(255, 50, 48, 48), fontSize: 20),
            ),
            Text(
              "Date: $date",
              style: const TextStyle(
                  color: Color.fromARGB(255, 50, 48, 48), fontSize: 20),
            ),
            Text(
              "Commission: $commission",
              style: const TextStyle(
                  color: Color.fromARGB(255, 50, 48, 48), fontSize: 20),
            ),
            Text(
              "Totsl: $total",
              style: const TextStyle(
                  color: Color.fromARGB(255, 50, 48, 48), fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 98, 87, 87), width: 2)),
              child: TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('transactions')
                      .doc(index)
                      .delete();

                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      )
                      .then((value) => setState(() {}));
                },
                child: const Text(
                  "Cancel Transaction",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 234, 175, 0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
