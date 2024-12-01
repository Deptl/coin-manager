import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseAnalyticsController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, double> incomeByCategory = {};

  Stream<List<Map<String, dynamic>>> fetchExpenseCategoryData(String userId) {
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('Transaction')
        .where('type', isEqualTo: "Expense")
        .snapshots()
        .map((querySnapshot) {
      Map<String, double> tempData = {};

      for (var doc in querySnapshot.docs) {
        String category = doc["category"] ?? "";
        double amount = doc["amount"]?.toDouble() ?? 0;

        if (tempData.containsKey(category)) {
          tempData[category] = tempData[category]! + amount;
        } else {
          tempData[category] = amount;
        }
      }
      incomeByCategory = tempData;
      return tempData.entries
          .map((entry) => {'category': entry.key, 'amount': entry.value})
          .toList();
    });
  }
}
