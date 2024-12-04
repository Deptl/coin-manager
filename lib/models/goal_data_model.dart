class GoalDataModel {
  String? dataId;
  String? note;
  double? amount;

  GoalDataModel({required this.dataId, required this.note, required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'dataId': dataId,
      'note': note,
      'amount': amount,
    };
  }

  factory GoalDataModel.fromMap(Map<String, dynamic> map) {
    return GoalDataModel(
      dataId: map['dataId'] ?? '',
      note: map['note'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0 ,
    );
  }
}