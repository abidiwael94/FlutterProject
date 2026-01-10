import 'package:flutter/material.dart';
import 'package:project_flutter/Models/event.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  Future<Event?> _getEventById(String eventId) async {
    final doc = await FirebaseFirestore.instance.collection('events').doc(eventId).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return Event(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteProvider(),
      child: Scaffold(
        body: Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, _) {
            final favorites = favoriteProvider.favorites;

            if (favorites.isEmpty) {
              return const Center(child: Text('No favorites yet'));
            }

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];

                return FutureBuilder<Event?>(
                  future: _getEventById(favorite.eventId),
                  builder: (context, eventSnapshot) {
                    if (!eventSnapshot.hasData) {
                      return const SizedBox();
                    }

                    final event = eventSnapshot.data!;

                    return ListTile(
                      leading: Image.network(
                        "https://picsum.photos/100/100?random=${event.id}",
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                      title: Text(event.title),
                      subtitle: Text("${event.date.toLocal()}".split(' ')[0]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          favoriteProvider.toggleFavorite(event.id);
                        },
                      ),
                      onTap: () {
                        // TODO: Navigate to EventDetailsScreen
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
