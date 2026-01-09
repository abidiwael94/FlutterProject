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
      appBar: AppBar(title: const Text("Events")),
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
          // Print snapshot state for debugging
          print("Snapshot has data: ${snapshot.hasData}");
          print("Snapshot error: ${snapshot.error}");
          print("Snapshot connectionState: ${snapshot.connectionState}");

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final events = snapshot.data ?? [];
          print("Number of events received: ${events.length}");
          for (var e in events) {
            print("Event: id=${e.id}, title=${e.title}");
          }

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
                      onPressed: () {
                        print("Deleting event id=${e.id}");
                        service.deleteEvent(e.id);
                      },
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
