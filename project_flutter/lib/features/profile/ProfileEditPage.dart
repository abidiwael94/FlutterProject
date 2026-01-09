import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/Models/user.dart';

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
    await _firestore.collection('users').doc(widget.user.id).update({
      'username': nameController.text.trim(),
      'email': emailController.text.trim(),
      // role is not updated
    });

    final updatedUser = User(
      id: widget.user.id,
      username: nameController.text.trim(),
      email: emailController.text.trim(),
      password: widget.user.password,
      role: widget.user.role,
      reservations: widget.user.reservations,
      favorites: widget.user.favorites,
    );

    // Return the updated user to previous screen
    Navigator.pop(context, updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 12),
            Text("Role: ${widget.user.role.name}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _save, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
