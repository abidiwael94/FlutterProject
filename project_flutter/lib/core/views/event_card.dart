import 'package:flutter/material.dart';
import '../../Models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final VoidCallback onReserve;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    required this.onFavorite,
    required this.onReserve,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF398AE5),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://picsum.photos/400/200?random=${event.id}",
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.25),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),

            /// Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // ✅ prevents overflow
                children: [
                  /// Title
                  Text(
                    event.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Date
                  Text(
                    "${event.date.toLocal()}".split(' ')[0],
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'OpenSans',
                      fontSize: 13,
                    ),
                  ),

                  const Spacer(),

                  /// Action buttons
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ActionButton(
                          icon: Icons.bookmark_border,
                          onPressed: onReserve,
                        ),
                        const SizedBox(width: 8),
                        _ActionButton(
                          icon: Icons.favorite_border,
                          onPressed: onFavorite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable action button
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
