import 'package:flutter/material.dart';
import '../../Models/event.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("${event.date.toLocal()}".split(' ')[0], style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Text(event.description),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO : faire les actions nécessaires (edit/delete si admin)
              },
              child: const Text('Faire le nécessaire'),
            ),
          ],
        ),
      ),
    );
  }
}
