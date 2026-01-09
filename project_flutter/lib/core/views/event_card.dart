import 'package:flutter/material.dart';
import '../../Models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventCard({super.key, required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: Icon(Icons.event, size: 40),
        title: Text(event.title),
        subtitle: Text("${event.date.toLocal()}".split(' ')[0]),
        onTap: onTap,
      ),
    );
  }
}
