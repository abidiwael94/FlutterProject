import 'package:flutter/material.dart';
import 'package:project_flutter/features/events/presentation/event_details_screen.dart';
import 'package:project_flutter/features/events/providers/event_provider.dart';
import 'package:provider/provider.dart';
import '../../core/views/event_card.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (provider.errorMessage != null) {
      return Scaffold(body: Center(child: Text(provider.errorMessage!)));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Événements')),
      body: ListView.builder(
        itemCount: provider.events.length,
        itemBuilder: (context, index) {
          final event = provider.events[index];
          return EventCard(
            event: event,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailsScreen(event: event),
                ),
              );
            }, onFavorite: () {  }, onReserve: () {  },
          );
        },
      ),
    );
  }
}
