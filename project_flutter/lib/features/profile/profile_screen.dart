import 'package:flutter/material.dart';
import 'package:project_flutter/Models/user.dart';
import 'package:project_flutter/features/profile/ProfileEditPage.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person, size: 80, color: Colors.blue),
          const SizedBox(height: 16),
          Text('Username: ${currentUser.username}', style: const TextStyle(fontSize: 24)),
          Text('Email: ${currentUser.email}', style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text('Role: ${currentUser.role.name}', style: const TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              final updatedUser = await Navigator.push<User>(
                context,
                MaterialPageRoute(builder: (_) => ProfileEditPage(user: currentUser)),
              );
              if (updatedUser != null) {
                setState(() {
                  currentUser = updatedUser;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile updated!")),
                );
              }
            },
            child: const Text("Edit Profile"),
          ),
        ],
      ),
    );
  }
}
