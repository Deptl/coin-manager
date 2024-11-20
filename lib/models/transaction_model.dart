class TransactionModel {
  String? transactionId;
  String? type;
  double? amount;
  String? category;
  String? account;
  String? createdAt;

  TransactionModel({required this.transactionId, required this.type, required this.amount, required this.category, required this.account, required this.createdAt});

  Map<String, dynamic> toJson(){
    return{
      "transactionId"
      "type": type,
      "amount": amount,
      "category": category,
      "account": account,
      "createdAt": createdAt
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json, String docId) {
    return TransactionModel(
      transactionId: json['transactionId'] ?? docId, 
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      account: json['account'] as String,
      createdAt: json['createdAt'],
    );
  }

}