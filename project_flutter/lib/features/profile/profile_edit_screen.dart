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
    print(
      "ProfileEditPage initialized with user: ${widget.user.username}, ${widget.user.email}",
    );
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

      // Fetch the latest user from Firestore
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

  @override
  Widget build(BuildContext context) {
    print("Building ProfileEditPage UI");
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
            Text(
              "Role: ${widget.user.role.name}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _save, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
