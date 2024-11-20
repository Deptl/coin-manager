import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_manager/models/transaction_model.dart';

class TransactionController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addTransaction(
      {required String userId,
      required String type,
      required double amount,
      required String category,
      required String account,
      required DateTime createdAt}) async {
    try {
      String iso8601String = createdAt.toUtc().toIso8601String();
      final transaction = TransactionModel(
          transactionId: "",
          type: type,
          amount: amount,
          category: category,
          account: account,
          createdAt: iso8601String);

      final docRef = await _firebaseFirestore
          .collection("Users")
          .doc(userId)
          .collection("Transaction")
          .add(transaction.toJson());
      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Error adding transaction: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getTransactionsStream({
    required String userId,
    required int month,
    required int year,
  }) {
    DateTime startDate = DateTime(year, month, 1);
    DateTime endDate = DateTime(year, month + 1, 0);

    return _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Transaction')
        .where('createdAt', isGreaterThanOrEqualTo: startDate.toIso8601String())
        .where('createdAt', isLessThanOrEqualTo: endDate.toIso8601String())
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }
}
