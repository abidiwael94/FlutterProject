import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/Models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUser(User user) async {
    await _firestore.collection('users').doc(user.id).update({
      'username': user.username,
      'email': user.email,
    });
  }

  
}
