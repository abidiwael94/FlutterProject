import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../../../core/views/event_card.dart';
import 'event_details_screen.dart';
import '../../../Models/user.dart';

class EventListScreen extends StatefulWidget {
  final User user;

  const EventListScreen({super.key, required this.user});

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
    final userId = widget.user.id;
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    if (provider.events.isEmpty) {
      return const Center(child: Text('Aucun événement disponible'));
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: provider.events.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
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
            },
            onFavorite: () async {
              await provider.addFavorite(event, userId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${event.title} Added to favorite')),
              );
            },
            onReserve: () async {
              await provider.addReservation(event, userId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Reserved for ${event.title}')),
              );
            },
          );
        },
      ),
    );
  }
}
