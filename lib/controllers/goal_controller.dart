import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_manager/models/goal_data_model.dart';
import 'package:coin_manager/models/goal_model.dart';

class GoalController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addGoal({
    required String userId,
    required String goalName,
    required double goalAmount,
  }) async {
    try {
      final goal = GoalModel(
        id: "",
        goalName: goalName,
        goalAmount: goalAmount,
      );

      final docRef = await _firebaseFirestore
          .collection("Users")
          .doc(userId)
          .collection("Goal")
          .add(goal.toJson());

      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Error adding goal: $e');
    }
  }
  
  Stream<List<GoalModel>> getGoalsStream({required String userId}) {
    return _firebaseFirestore
        .collection("Users")
        .doc(userId)
        .collection("Goal")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return GoalModel.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> addGoalData({required String userId, required String note, required String amount}) async {
    try {
      final parsedAmount = double.tryParse(amount) ?? 0.0;
      final goalData = GoalDataModel(
        dataId: "",
        note: note,
        amount: parsedAmount,
      );

      final docRef = await _firebaseFirestore
          .collection("Users")
          .doc(userId)
          .collection("GoalData")
          .add(goalData.toMap());

      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('Error adding goal: $e');
    }
  }

  Stream<List<GoalDataModel>> getGoalDataStream({required String userId}) {
    return _firebaseFirestore
        .collection("Users")
        .doc(userId)
        .collection("GoalData")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return GoalDataModel.fromMap(doc.data());
      }).toList();
    });
  }
}