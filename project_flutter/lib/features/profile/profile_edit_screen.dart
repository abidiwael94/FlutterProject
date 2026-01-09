import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/Models/user.dart';
import 'package:project_flutter/core/constants/constants.dart';

class ProfileEditPage extends StatefulWidget {
  final User user;
  const ProfileEditPage({super.key, required this.user});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.username);
    emailController = TextEditingController(text: widget.user.email);
  }

  Future<void> _save() async {
    final username = nameController.text.trim();
    final email = emailController.text.trim();

    if (username.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username and Email cannot be empty")),
      );
      return;
    }

    try {
      final userDoc = _firestore.collection('user').doc(widget.user.id);

      final docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        await userDoc.update({'username': username, 'email': email});
      } else {
        await userDoc.set({'username': username, 'email': email});
      }

      final freshSnapshot = await userDoc.get();
      final freshData = freshSnapshot.data()!;
      final updatedUser = User(
        id: widget.user.id,
        username: freshData['username'],
        email: freshData['email'],
        password: widget.user.password,
        role: widget.user.role,
        reservations: widget.user.reservations,
        favorites: widget.user.favorites,
      );

      Navigator.pop(context, updatedUser);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error saving profile: $e")));
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: kLabelStyle),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        child: const Text(
          'SAVE',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Edit Profile'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Username',
                  hint: 'Enter username',
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Email',
                  hint: 'Enter email',
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                _buildSaveButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
