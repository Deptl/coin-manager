class BudgetModel {
  String? id;
  String? month;
  double? amount;

  BudgetModel({
    required this.id,
    required this.month,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'month': month,
      'amount': amount,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      month: map['month'],
      amount: map['amount'].toDouble(),
    );
  }
}
