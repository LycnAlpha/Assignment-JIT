import 'package:assignment_jit/tabs/transactionTypes.dart';
import 'package:assignment_jit/widgets/transactions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int itemcount = 0;

  @override
  void initState() {
    super.initState();
    checkCount();
    setState(() {});
  }

  void checkCount() async {
    await FirebaseFirestore.instance
        .collection("transactions")
        .count()
        .get()
        .then(
          (res) => itemcount = res.count,
          onError: (e) => print("Error completing: $e"),
        );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 221, 212, 212),
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              text: "Transactions List ($itemcount)",
            ),
            Tab(
              text: "Transaction Types",
            )
          ]),
          title: const Text("Transactions"),
          backgroundColor: const Color.fromARGB(255, 245, 202, 72),
        ),
        body: TabBarView(children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('transactions')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) => Container(
                          child: Transactions(
                            snap: snapshot.data!.docs[index].data(),
                          ),
                        )));
              }),
          TransactionTypes()
        ]),
      ),
    );
  }
}
