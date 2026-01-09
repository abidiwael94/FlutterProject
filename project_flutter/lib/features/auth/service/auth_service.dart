import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:project_flutter/Models/user_role.dart';
import 'package:project_flutter/Models/user.dart';

class AuthService {
  final fbAuth.FirebaseAuth _auth = fbAuth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Login with email & password
  Future<User?> login({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      // Fetch user data from Firestore
      final doc = await _firestore.collection('user').doc(uid).get();
      if (!doc.exists) return null;

      final data = doc.data()!;
      return User(
        id: data['id'],
        username: data['username'],
        email: data['email'],
        password: data['password'],
        role: UserRole.values.firstWhere(
          (r) => r.name == data['role'],
          orElse: () => UserRole.user,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

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
