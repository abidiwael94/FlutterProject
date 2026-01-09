import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/Models/user.dart';
import 'package:project_flutter/Models/user_role.dart';
import 'package:project_flutter/features/profile/profile_edit_screen.dart';



class ProfileScreen extends StatelessWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final userDoc = FirebaseFirestore.instance.collection('user').doc(userId);

    return StreamBuilder<DocumentSnapshot>(
      stream: userDoc.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final data = snapshot.data!.data() as Map<String, dynamic>;
        final user = User(
          id: userId,
          username: data['username'],
          email: data['email'],
          password: '', // keep it if needed
          role: UserRole.user, // or read from Firestore if stored
          reservations: [],
          favorites: [],
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Center(child: Icon(Icons.person, size: 80, color: Colors.blue)),
              const SizedBox(height: 16),
              Text('Username: ${user.username}', style: const TextStyle(fontSize: 24)),
              Text('Email: ${user.email}', style: const TextStyle(fontSize: 18, color: Colors.grey)),
              Text('Role: ${user.role.name}', style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final updatedUser = await Navigator.push<User>(
                      context,
                      MaterialPageRoute(builder: (_) => ProfileEditPage(user: user)),
                    );
                  },
                  child: const Text("Edit Profile"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
