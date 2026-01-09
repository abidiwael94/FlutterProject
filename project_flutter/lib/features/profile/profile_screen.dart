import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_flutter/Models/user.dart';
import 'package:project_flutter/Models/user_role.dart';
import 'package:project_flutter/features/profile/profile_edit_screen.dart';
import 'package:project_flutter/core/constants/constants.dart';
import 'package:project_flutter/core/views/custom_snack_bar.dart';

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
          password: '',
          role: UserRole.user,
          reservations: [],
          favorites: [],
        );

        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: [
                // Gradient background
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF73AEF5),
                        Color(0xFF61A4F1),
                        Color(0xFF478DE0),
                        Color(0xFF398AE5),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, size: 100, color: Colors.white),
                      const SizedBox(height: 20),
                      // Username
                      _buildInfoBox(label: 'Username', value: user.username),
                      const SizedBox(height: 16),
                      // Email
                      _buildInfoBox(label: 'Email', value: user.email),
                      const SizedBox(height: 16),
                      // Role
                      _buildInfoBox(label: 'Role', value: user.role.name),
                      const SizedBox(height: 40),
                      // Edit Profile button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final updatedUser = await Navigator.push<User>(
                              context,
                              MaterialPageRoute(builder: (_) => ProfileEditPage(user: user)),
                            );
                            if (updatedUser != null) {
                              CustomSnackBar.show(context, 'Profile updated!', isError: false);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'EDIT PROFILE',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoBox({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: kLabelStyle.copyWith(color: Colors.white)),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: kBoxDecorationStyle.copyWith(
            color: Colors.white.withOpacity(0.2),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ],
    );
  }
}
