import 'package:cloud_firestore/cloud_firestore.dart';

class transactionModel {
  final String? transactionId;
  final String? type;
  final String? amount;
  final String? commission;
  final String? date;
  final String? total;

  transactionModel({
    this.transactionId,
    this.type,
    this.amount,
    this.commission,
    this.date,
    this.total,
  });

  factory transactionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return transactionModel(
      transactionId: data?['transactionId'],
      type: data?['type'],
      amount: data?['amount'],
      commission: data?['commission'],
      date: data?['date'],
      total: data?['total'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (transactionId != null) "transactionId": transactionId,
      if (type != null) "type": type,
      if (amount != null) "amount": amount,
      if (commission != null) "commission": commission,
      if (date != null) "date": date,
      if (total != null) "total": total,
    };
  }
}
