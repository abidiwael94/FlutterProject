import 'package:flutter/material.dart';
import 'package:project_flutter/Models/event.dart';
import 'event_form_screen.dart';
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
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color(0xFF527DAA)),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventFormPage(service: service)),
        ),
      ),
      body: Stack(
        children: [
          // Gradient background
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
          StreamBuilder<List<Event>>(
            stream: service.getEvents(),
            builder: (context, snapshot) {
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

              if (events.isEmpty) {
                return const Center(
                  child: Text(
                    "No events",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: events.length,
                itemBuilder: (context, i) {
                  final e = events[i];
                  return Card(
                    color: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        e.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        e.date.toLocal().toString().split(" ")[0],
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EventFormPage(service: service, event: e),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              print("Deleting event id=${e.id}");
                              service.deleteEvent(e.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
