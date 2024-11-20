class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? hashPassword;
  DateTime? createdAt;

  UserModel({required this.userId, required this.firstName, required this.lastName, required this.email, required this.hashPassword, required this.createdAt});

  Map<String, dynamic> toJson(){
    return {
      "userId": userId,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "hashPassword": hashPassword,
      "createdAt" : createdAt?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      hashPassword: json['hashPassword'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}