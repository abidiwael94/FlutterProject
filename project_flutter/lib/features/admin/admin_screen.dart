import 'package:flutter/material.dart';
import 'package:project_flutter/Models/user.dart';
import 'package:project_flutter/features/admin/event_list.dart';

class AdminPage extends StatelessWidget {
  final User user;

  const AdminPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Expanded(child: EventListPage())]),
    );
  }
}
