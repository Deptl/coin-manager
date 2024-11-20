import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_manager/models/user_model.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String encryptedPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> createUser(UserModel user, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: password,
      );

      final String userId = userCredential.user!.uid;
      final String passwordHash = encryptedPassword(password);

      final userWithId = UserModel(
          userId: userId,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          hashPassword: passwordHash,
          createdAt: DateTime.now());

      await _firestore.collection('Users').doc(userId).set(userWithId.toJson());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<UserModel?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      String userId = userCredential.user!.uid;
      DocumentSnapshot userSnapshot =
          await _firestore.collection('Users').doc(userId).get();

      if (userSnapshot.exists) {
        return UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception('User not found in Firestore');
      }
    } catch (e) {
      print("Error during login: $e");
      throw Exception('Failed to login: $e');
    }
  }
}
