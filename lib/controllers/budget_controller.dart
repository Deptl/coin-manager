import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_manager/models/budget_model.dart';
import 'package:intl/intl.dart';

class BudgetController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addBudget({
    required String userId,
    required String month,
    required double amount,
  }) async {
    try {
      final budget = BudgetModel(
        id: "",
        month: month,
        amount: amount,
      );

      final docRef = await _firebaseFirestore
          .collection("Users")
          .doc(userId)
          .collection("Budget")
          .add(budget.toJson());

      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Error adding budget: $e');
    }
  }

  Future<BudgetModel?> getBudget({
    required String userId,
    required String month,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("Users")
          .doc(userId)
          .collection("Budget")
          .where('month', isEqualTo: month)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return BudgetModel.fromMap(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Error retrieving budget: $e');
    }
  }

  Stream<List<BudgetModel>> getBudgetsStream({
    required String userId,
  }) {
    return _firebaseFirestore
        .collection("Users")
        .doc(userId)
        .collection("Budget")
        .orderBy('month', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return BudgetModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getExpenseTransactionsStream({
    required String userId,
    required int month,
    required int year,
  }) {
    final String formattedMonthYear =
        _monthYearFormat(month: month, year: year);
    return _firebaseFirestore
        .collection('Users')
        .doc(userId)
        .collection('Transaction')
        .where('type', isEqualTo: 'Expense')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            final DateTime createdAt = DateTime.parse(data['createdAt']);
            final String transactionMonthYear = _monthYearFormat(
              month: createdAt.month,
              year: createdAt.year,
            );

            if (transactionMonthYear == formattedMonthYear) {
              return data;
            }
            return null;
          })
          .where((doc) => doc != null)
          .cast<Map<String, dynamic>>()
          .toList();
    });
  }

  String _monthYearFormat({required int month, required int year}) {
    final DateTime date = DateTime(year, month);
    return DateFormat('MMMM yyyy').format(date);
  }
}
