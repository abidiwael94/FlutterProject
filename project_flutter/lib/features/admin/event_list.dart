import 'package:flutter/material.dart';
import 'package:project_flutter/Models/event.dart';
import 'event_form.dart';
import 'event_service.dart';


class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final EventService service = EventService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventFormPage(service: service)),
        ),
      ),
      body: StreamBuilder<List<Event>>(
        stream: service.getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final events = snapshot.data!;
          if (events.isEmpty) return const Center(child: Text("No events"));

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (_, i) {
              final e = events[i];
              return ListTile(
                title: Text(e.title),
                subtitle: Text(e.date.toLocal().toString().split(" ")[0]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventFormPage(service: service, event: e),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => service.deleteEvent(e.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
