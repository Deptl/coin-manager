class GoalModel {
  String? id;
  String? goalName;
  double? goalAmount;

  GoalModel({
    required this.id,
    required this.goalName,
    required this.goalAmount,
  });

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'goalName': goalName,
      'goalAmount': goalAmount,
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'],
      goalName: map['goalName'],
      goalAmount: map['goalAmount'].toDouble(),
    );
  }
}