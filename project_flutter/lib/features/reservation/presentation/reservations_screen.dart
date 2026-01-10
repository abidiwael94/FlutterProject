import 'package:flutter/material.dart';
import 'package:project_flutter/Models/user.dart';
import 'package:project_flutter/Models/reservation.dart';
import 'package:project_flutter/features/reservation/providers/reservation_provider.dart';
import 'package:provider/provider.dart';

class ReservationsScreen extends StatelessWidget {
  final User user; 
  const ReservationsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final resProvider = Provider.of<ReservationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("My Reservations")),
      body: StreamBuilder<List<Reservation>>(
        stream: resProvider.getReservations(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("🎟️", style: TextStyle(fontSize: 50)),
                  const Text("Aucune réservation trouvée", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("ID: ${user.id}", style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          final reservations = snapshot.data!;
          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final item = reservations[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.event, color: Colors.blue),
                  title: Text("Événement: ${item.eventId}"),
                  subtitle: Text("Réservé le: ${item.reservedAt}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => resProvider.deleteReservation(item.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}