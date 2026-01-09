import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:project_flutter/Models/user_role.dart';
import 'package:project_flutter/Models/user.dart';

class AuthService {
  final fbAuth.FirebaseAuth _auth = fbAuth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final username = '$firstName $lastName';
      final role = UserRole.user;

      final userDoc = {
        'id': uid,
        'username': username,
        'email': email,
        'password': password,
        'role': role.name,
      };

      await _firestore.collection('user').doc(uid).set(userDoc);

      return User(
        id: uid,
        username: username,
        email: email,
        password: password,
        role: role,
      );
    } catch (e) {
      rethrow;
    }
  }
}
